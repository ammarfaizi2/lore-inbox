Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUGDRdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUGDRdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUGDRdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:33:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62143 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265219AbUGDRdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:33:23 -0400
Message-ID: <40E83F53.3050006@pobox.com>
Date: Sun, 04 Jul 2004 13:33:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>, Matt Domsch <Matt_Domsch@dell.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
References: <40E76CC5.6020903@pobox.com> <20040704063321.GB5054@openzaurus.ucw.cz>
In-Reply-To: <20040704063321.GB5054@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>This appeared in -bk-latest in the past day or two.
>>
>>BK-current on x86-64 (config/dmesg/lspci attached) will pause for 30 
>>wall-clock seconds immediately after being loaded by the bootloader, 
>>then will proceed to boot successfully and function correctly.  This 
>>is reproducible on every boot.
>>
>>So, 30 seconds with no printk output, then boots normally.
>>
> 
> 
> Search archives, there was something similar seen before.
> It was related to EDD, or some similar BIOS feature, IIRC.


Thank you for the hint!

I verified that changing CONFIG_EDD=y to '# CONFIG_EDD is not set' 
removed the 30-second pause at boot.

This 30-second pause only appeared recently on my x86-64 box (VIA-based 
Athlon64), so I'll bsearch changesets when I get a free moment (sometime 
this week).

I wonder, even, if it is related to the bootsetup.h fix from Matt that I 
forwarded recently.

	Jeff


