Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUIFG35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUIFG35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 02:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUIFG34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 02:29:56 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:5783 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S266808AbUIFG3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 02:29:55 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Dominik Brodowski <linux@dominikbrodowski.de>
Date: Mon, 06 Sep 2004 08:26:07 +0200
MIME-Version: 1.0
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
CC: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Message-ID: <413C1F21.32130.254827@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <20040903202615.GA18255@dominikbrodowski.de>
References: <1094240482.14662.525.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93227@20040906.061834Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2004 at 22:26, Dominik Brodowski wrote:

...
> What about removing cpu_freq_khz you have in your patch, adding a per-CPU 
> value, and just use the value of the boot CPU for the other CPUs if
> !CONFIG_DIFFERENT_CPU_SPEEDS or something like that?
...

I would not mention SMP at that stage, but most of the existing code on IA32 
suumes that all CPUs run with the same frequency. I only heared that at least on 
Alphas this is not true. Probably you'll need a per-CPU state regarding time. Most 
likely resulting in the "local CPU's time" and a global concept of time that 
should not be in contradiction with any CPU's time. That might mean that any 
process always has to query the global time, involving extra overhead.

You mentioned it...

Regards,
Ulrich


