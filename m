Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269535AbUINQNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269535AbUINQNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269516AbUINQL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:11:57 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:63917 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269457AbUINQEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:04:25 -0400
Message-ID: <4147167B.9080202@drzeus.cx>
Date: Tue, 14 Sep 2004 18:04:11 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: seife@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: HP/Compaq (Winbond) SD/MMC reader supported
References: <41383D02.5060709@drzeus.cx> <20040913223827.GA28524@elf.ucw.cz> <41467216.6070508@drzeus.cx> <20040914150013.GB27621@elf.ucw.cz> <41470B5A.2010005@drzeus.cx> <20040914152406.GA9581@elf.ucw.cz>
In-Reply-To: <20040914152406.GA9581@elf.ucw.cz>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>Is the 0xf00 id the only one you get? If it is a SuperIO chip then 
>>    
>>
>
>How can I (try to) get other id's? Yes, it seems to be stable across reboots.
>
>  
>
You don't. The driver will list all it finds, so if there's only one 
line then that's it.

>>resetting it will probably cause all sorts of funky problems.
>>Do you know what SuperIO is used in the machine? And have you tried 
>>confirming that the card reader is indeed winbond? The easiest way to do 
>>that is to see if the Windows driver is wbsd.sys.
>>    
>>
>
>Stefan, could you take a look? I rm -rf'ed my copy of windows :-(.
>
>SuperIO is behind ISA bridge so it can not be deduced from lspci? Or I
>may be completely off mark; there's Unknown mass storage controller:
>Texas Instruments PCI7420 Flash Media Controller.... Hmm, that seems
>like flash.
>  
>
PCI7420 does indeed support SD/MMC so there's a high probability that 
this is the wrong driver for you. See if TI will release a complete 
spec. for the SD/MMC interface. Then you can start writing your own 
driver ;)

Rgds
Pierre

