Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSKGPUO>; Thu, 7 Nov 2002 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSKGPUN>; Thu, 7 Nov 2002 10:20:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58511 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261258AbSKGPUM>; Thu, 7 Nov 2002 10:20:12 -0500
Date: Thu, 07 Nov 2002 07:23:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       me Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent  2.5)
Message-ID: <4045881620.1036653833@[10.10.2.3]>
In-Reply-To: <200211071518.gA7FIWv02566@localhost.localdomain>
References: <200211071518.gA7FIWv02566@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The question really is whether the secondaries need to receive any interrupts 
> at all (except for the one that booted them) before the smp_commence mask is 
> cleared.  I don't believe this to be the case.  calibrate_delay only requires 
> that jiffies be ticking, which will happen as long as the boot cpu is 
> receiving timer interrupts.  Perhaps the correct fix is not to enable the 
> interrupts early in the start_secondary sequence, and not to lower the APIC 
> (or VIC in my case) interrupt masks at all until after smp_commence.  Thus the 
> boot CPU will handle all the interrupts up until that point.

Someone suggested that the other arches do all this in a different 
order. Would someone who knows about them care to explain what they
do differently and why, or at least point me to an arch to look at
that does this well?

M.

