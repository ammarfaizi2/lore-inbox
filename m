Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVLEBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVLEBQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 20:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVLEBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 20:16:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750710AbVLEBQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 20:16:31 -0500
Date: Sun, 4 Dec 2005 20:16:11 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051205011611.GA12664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133725767.19768.12.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 02:49:26PM -0500, Lee Revell wrote:
 > On Sun, 2005-12-04 at 19:32 +0100, Andi Kleen wrote:
 > > On Sun, Dec 04, 2005 at 05:43:35PM +0100, Dominik Brodowski wrote:
 > > > On Fri, Dec 02, 2005 at 10:43:20AM -0800, Venkatesh Pallipadi wrote:
 > > > > The patch below changes this to:
 > > > > Show the last known frequency of the particular CPU, when cpufreq is present. If
 > > > > cpu doesnot support changing of frequency through cpufreq, then boot frequency 
 > > > > will be shown. The patch affects i386, x86_64 and ia64 architectures.
 > > > 
 > > > Looks good to me -- however, might this affect userspace cpufreq tools? I'd
 > > 
 > > They normally use /sys anyways.
 > 
 > Wrong, lots of userspace programs that need to know the CPU speed get it
 > from /proc/cpuinfo.  It would be nice if there were a better API.

I can't think of a single valid reason why a program would want
to know the MHz rating of a CPU. Given that it's a) approximate,
b) subject to change due to power management, c) completely nonsensical
across CPU vendors, and d) only one of many variables regarding CPU
performance, any program that bases any decision on the values found
by parsing that field of /proc/cpuinfo is utterly broken beyond belief.

Adding any other interface to obtain this value is equally as broken.

		Dave

