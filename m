Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUH1GUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUH1GUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUH1GUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:20:13 -0400
Received: from jade.spiritone.com ([216.99.193.136]:49852 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266898AbUH1GR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:17:59 -0400
Date: Fri, 27 Aug 2004 23:17:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
cc: William Lee Irwin III <wli@holomorphy.com>, James <jamesclv@us.ibm.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] fix target_cpus() for summit subarch
Message-ID: <79750000.1093673866@[10.10.2.4]>
In-Reply-To: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
References: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--john stultz <johnstul@us.ibm.com> wrote (on Friday, August 27, 2004 17:24:48 -0700):

> I've been hunting down a bug affecting IBM x440/x445 systems where the
> floppy driver would get spurious interrupts and would not initialize
> properly. 
> 
> After digging James Cleverdon pointed out that target_cpus() is routing
> the interrupts to the clustered apic broadcast mask. This was causing
> multiple interrupts to show up, breaking the floppy init code. 
> 
> This one-liner fix simply routes interrupts to the first cpu to resolve
> this issue.

I'd say that means your hardware is horribly broken ... but I guess this
might be a suitable workaround given we're going to reprogram them all
later.

So ... do all your interrupts end up on the first cpu now, or does
irqbalance take care of it?

M.

