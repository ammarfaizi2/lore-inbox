Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310240AbSCLAhk>; Mon, 11 Mar 2002 19:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310243AbSCLAhb>; Mon, 11 Mar 2002 19:37:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22459 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310240AbSCLAhQ>; Mon, 11 Mar 2002 19:37:16 -0500
Date: Mon, 11 Mar 2002 16:36:57 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>,
        Adam K Kirchhoff <adamk@voicenet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP & APIC problem.
Message-ID: <132630000.1015893417@flay>
In-Reply-To: <Pine.LNX.4.33.0203111920430.1437-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0203111920430.1437-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> My second question:  Is there any chance of getting this working with
>> APIC, if not in 2.4.* maybe in a future release?
> 
> given that it's a hardware problem, no.  but it *would* be cool
> if the kernel noticed repeated APIC warnings and just turned 
> off apic use (as if you had booted with noapic).  I'm guessing
> this would be ugly, since APIC setup is probably discarded after boot...

There were some patches floating around to do exactly this (don't
remember where, sorry ;-) )

There's also an esr_disable flag variable I put in a while back
when doing bringup of NUMA-Q to smack the ESR into submission. 
You might want to try tweaking that on in smp.h. It's not like we
actually do anything with the errors anyway. (all assuming my
mind isn't faulty, and this is actually the same thing). The read / 
write protocol for ESR is really .... wierd, and it seems to need
smacking multiple times to accept a write.

M.

