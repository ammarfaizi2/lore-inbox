Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUIGQUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUIGQUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIGQSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:18:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64462 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268111AbUIGQRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:17:21 -0400
Date: Tue, 7 Sep 2004 09:14:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Len Brown <len.brown@intel.com>, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
In-Reply-To: <413C1F21.32130.254827@rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.58.0409070912460.8484@schroedinger.engr.sgi.com>
References: <1094240482.14662.525.camel@cog.beaverton.ibm.com>
 <413C1F21.32130.254827@rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004, Ulrich Windl wrote:

> On 3 Sep 2004 at 22:26, Dominik Brodowski wrote:
>
> ...
> > What about removing cpu_freq_khz you have in your patch, adding a per-CPU
> > value, and just use the value of the boot CPU for the other CPUs if
> > !CONFIG_DIFFERENT_CPU_SPEEDS or something like that?
> ...
>
> I would not mention SMP at that stage, but most of the existing code on IA32
> suumes that all CPUs run with the same frequency. I only heared that at least on
> Alphas this is not true. Probably you'll need a per-CPU state regarding time. Most
> likely resulting in the "local CPU's time" and a global concept of time that
> should not be in contradiction with any CPU's time. That might mean that any
> process always has to query the global time, involving extra overhead.

CPUs in SGI Altix systems may also run at different frequencies.
Typically 2 CPUs have a common clock source. For example in a system of
16 CPUs, there may exist 8 clock sources that slightly diverge from one
another.
