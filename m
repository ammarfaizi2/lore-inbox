Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVKSXwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVKSXwz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 18:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVKSXwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 18:52:55 -0500
Received: from [202.65.75.150] ([202.65.75.150]:3289 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S1751066AbVKSXwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 18:52:54 -0500
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Sun, 20 Nov 2005 10:47:08 +1100
To: Chris Largret <largret@gmail.com>
Cc: jstipins@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: AMD 64 system clock speed
Message-ID: <20051119234708.GH25348@bakeyournoodle.com>
Mail-Followup-To: Chris Largret <largret@gmail.com>, jstipins@umich.edu,
	linux-kernel@vger.kernel.org
References: <20051118200132.jiwizt3ho0ook00w@web.mail.umich.edu> <1132434746.18950.9.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132434746.18950.9.camel@shogun.daga.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 01:12:26PM -0800, Chris Largret wrote:
> On Fri, 2005-11-18 at 20:01 -0500, jstipins@umich.edu wrote:
> > Hi there,
> > 
> > My earlier question regarding the glibc "make check" nptl/tst-clock2.c
> > failure turns out to be due to my system clock running 3x normal speed.
> > 
> > Evidently, this is a known issue with 2.6.x kernels running on AMD 64
> > processors.  The "noapic" boot option fixes the clock problem, but disrupts
> > other things... ethernet does work, etc.  The solution seems to be using
> > "apci=noirq noapic" as boot options.
> > 
> > I am using the 2.6.14.2 kernel, and still need to use those boot parameters.
> > What is the current state of this bug?
> 
> Interestingly, I found out last night that the 2.4.26 kernel can
> recognize both processors in my X2. Unfortunately, it had the same time
> synchronization issues as the newer 2.6.12+ kernels that I have been
> running. It isn't solely related to the new kernel series.

You could also be seeing the same problem outlined in.
	http://marc.theaimsgroup.com/?t=113097284500003&r=2&w=2

Try booting with: acpi_skip_timer_override instead of the other command
line parameters.

Yours Tony

   linux.conf.au       http://linux.conf.au/ || http://lca2006.linux.org.au/
   Jan 23-28 2006      The Australian Linux Technical Conference!

