Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286223AbRL0HNo>; Thu, 27 Dec 2001 02:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286224AbRL0HNe>; Thu, 27 Dec 2001 02:13:34 -0500
Received: from [194.228.240.2] ([194.228.240.2]:40207 "EHLO chudak.century.cz")
	by vger.kernel.org with ESMTP id <S286223AbRL0HNS>;
	Thu, 27 Dec 2001 02:13:18 -0500
Message-ID: <3C2AC9FF.8050301@century.cz>
Date: Thu, 27 Dec 2001 08:13:03 +0100
From: Petr Titera <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.6+) Gecko/20011203
X-Accept-Language: en-us
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:

> Hi!
> 
> When trying to mount an ISO9660 CD on my USB CDRW unit, I get lots
> of "sr: unaligned transfer" messages from the kernel and the mount
> command fails. This message was added in kernel 2.5.1 and the
> sr_scatter_pad() function was removed at the same time. The comment
> above the message hints that unaligned transfers are (or were) a
> normal thing.
> 
> I added a printk to get more information:
> 
>         sr: unaligned transfer
>         sr: sector 64, s_size 2048, bufflen 1024
>         sr: unaligned transfer
>         sr: sector 68, s_size 2048, bufflen 1024
>         sr: unaligned transfer
>         sr: sector 72, s_size 2048, bufflen 1024
>         ...
>         sr: unaligned transfer
>         sr: sector 396, s_size 2048, bufflen 1024
>         Unable to identify CD-ROM format.
> 
> So, what changes are needed to make CD support work?
> 
> 

Use -o block=2048 as your mount option. There is error in sr code 
causing block sizes of CD-ROM drives to be incorrectly initialized to 
1024 bytes.


Petr Titera
P.Titera@century.cz

