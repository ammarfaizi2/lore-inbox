Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754817AbWKIJqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbWKIJqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbWKIJqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:46:48 -0500
Received: from iona.labri.fr ([147.210.8.143]:13541 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1754817AbWKIJqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:46:47 -0500
Message-ID: <4552F905.3020109@ens-lyon.org>
Date: Thu, 09 Nov 2006 10:46:45 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com> <20061030132745.GE4563@kernel.dk>
In-Reply-To: <20061030132745.GE4563@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ens Axboe wrote:
> On Mon, Oct 30 2006, Gregor Jasny wrote:
>   
>> 2006/10/30, Jens Axboe <jens.axboe@oracle.com>:
>>     
>>> Can you confirm that 2.6.18 works?
>>>       
>> The reporter of [1] states that his SATA Thinkpad freezes with 2.6.17
>> and 2.6.18, too.
>>
>> Gregor
>>
>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=391901
>>     
>
> Ok, mainly just checking if this was a potential dupe of another bug.
>
>   

Jens (or anybody else who has any idea of how to debug this),

Did you have a chance to reproduce the problem? I guess we "only" need a
machine with SATA/ata_piix and cdparanoia 3.10. If you want me to debug
some stuff, feel free to tell me what. But, since it freezes the machine
and sysrq doesn't even work, I don't really know what to try...

I just tried on rc5 and rc5-mm1, both have the problem (as 2.6.16, .17
and .18 do, don't know about earlier kernels). I didn't have a audio CD
here, so I tried abcde on a DVD on purpose. With cdparanoia 3.10-pre0
(from Debian testing), it reports nothing during about 5 seconds and
then the machine freezes. With cdparanoia 3a9.8-11 (from Debian stable),
it reports an error very quickly, and dmesg gets a couple line like these:
    sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing
data in;
       program cdparanoia not setting count and/or reply_len properly

Thanks,
Brice

