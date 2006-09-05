Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWIEUo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWIEUo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWIEUo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:44:27 -0400
Received: from mail.tmr.com ([64.65.253.246]:20646 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1161047AbWIEUo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:44:26 -0400
Message-ID: <44FDE2A0.3080705@tmr.com>
Date: Tue, 05 Sep 2006 16:48:32 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel,gmane.linux.ide
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
References: <44FC0779.9030405@garzik.org> <1157371363.30801.31.camel@localhost.localdomain>
In-Reply-To: <1157371363.30801.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-09-04 am 07:01 -0400, ysgrifennodd Jeff Garzik:
>> The following must be in all caps, though:
>>
>> drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
>> CHOOSE.
> 
> Except optionally for the following for chips not handled by or broken
> totally in drivers/ide:
> 
> 	pata_mpiix - some early pentium era laptops
> 	pata_oldpiix - original "PIIX" chipset
> 	pata_radisys - embedded chipset
> 
> The other apparently "libata only" chips are pata_jmicron and
> pata_optidma. There are patches to handle these as "generic" PCI IDE in
> the base 2.6.18 tree already so only features will be lost (eg mode
> switching). As Jeff implies distributions should be using drivers/ide
> for the Jmicron PATA and the Opti DMA PATA for now.
> 
>> * /dev/sdX supports fewer partitions than /dev/hdX (16 versus 64, IIRC)
>>
>> * /dev/sdX does not support all the HDIO_xxx ioctls that /dev/hdX does. 
>>   In practice, the ioctls we ignored are ones that very few people care 
>> about.
> 
> Add "/dev/sr*" does not support partitions. (That needs fixing anyway)
>     
>> * ARM, PPC and other non-x86 platform drivers are severely 
>> under-represented.
> 
> libata needs changes for this too. I have some stuff saved from the
> older discussions to look at.
> 
>> As an aside, I would love to see paride updated to use libata, but we 
>> can probably count the number of paride users on one hand these days...
> 
> and thats without using fingers or thumbs.
> 
> 
I still use that interface, although I can't say it's critical if I 
can't upgrade at some point. There are some other users in the local UG, 
but they are probably not ever going to upgrade.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
