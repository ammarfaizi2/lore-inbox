Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWCJSDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWCJSDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWCJSDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 13:03:13 -0500
Received: from [69.90.147.196] ([69.90.147.196]:32651 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S1751053AbWCJSDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 13:03:11 -0500
Message-ID: <4411C07C.4000005@kenati.com>
Date: Fri, 10 Mar 2006 10:07:56 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: How can I link the kernel with libgcc ?
References: <4410D9F0.6010707@kenati.com>	<200603100145.k2A1jMem005323@turing-police.cc.vt.edu>	<1141956362.13319.105.camel@mindpipe> <4410EC0D.3090303@kenati.com>	<4410F1BE.7000904@kenati.com> <yq0ek1a38n2.fsf@jaguar.mkp.net>
In-Reply-To: <yq0ek1a38n2.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:

>>>>>>"Carlos" == Carlos Munoz <carlos@kenati.com> writes:
>>>>>>            
>>>>>>
>
>Carlos> I figured out how to get the driver to use floating point
>Carlos> operations. I included source code (from an open source math
>Carlos> library) for the log10 function in the driver. Then I added
>Carlos> the following lines to the file arch/sh/kernel/sh_ksyms.c:
>
>Bad bad bad!
>
>You shouldn't be using floating point in the kernel at all! Most
>architectures do not save the full floating point register set on
>entry so if you start messing with the fp registers you may corrupt
>user space applications.
>
>You need to either write a customer user space app or use a table as
>Arjan suggested.
>E_OK
>Cheers,
>Jes
>  
>
Hi Jes,

I wasn't aware that floating point registers are not save. I guess I 
have no choice but to use a table.

Thanks,


Carlos Munoz
