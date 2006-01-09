Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWAIUQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWAIUQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWAIUQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:16:07 -0500
Received: from drugphish.ch ([69.55.226.176]:52153 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751307AbWAIUQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:16:06 -0500
Message-ID: <43C2C482.6090904@drugphish.ch>
Date: Mon, 09 Jan 2006 21:16:02 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local> <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org> <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch> <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_DEBUG_SLAB=y
>> CONFIG_MAGIC_SYSRQ=y
>> CONFIG_FRAME_POINTER=y
> 
> kernel, sysrq, and frame_pointer were already enabled.  I'll enable 
> debug_slab, as well.

Excellent.

>>> booting with "nosmp acpi=off" did not help.  The box hung as before, at
>>
>> Could you boot with pci=noacpi and report again? The difference is 
>> that ACPI will still be used but not for IRQ routing. I have a few 
>> boxes out with 2.4.x kernels and Adaptec HBAs that need this to work 
>> reliably.
> 
> Are you interested in results from "pci=noacpi" by itself or in 
> conjunction with nosmp?

With SMP, please.

>> What's the SCSI BIOS version?
> 
> The SCSI controller is an onboard AIC 7899 (in a Dell PowerEdge 2650), 
> and reports itself as "25309".

What I meant was the SCSI Bios revision you get to see when you cold 
reset the system.

>> If you find time, send me your BIOS settings and your .config in 
>> private email. I didn't track this thread from the beginning, so I 
>> don't know if you've already done this.
> 
> <http://hashbrown.cts.ucla.edu/pub/oops-200512/> has the .config, lspci 
> -v, and /proc/interrupts for 2.6.14.4 and 2.4.32.

Thanks, I'll skim over these and get back to you if I can correlate 
anything with the issues we were having using this controller.

Regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
