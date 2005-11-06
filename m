Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVKFENs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVKFENs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVKFENs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:13:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52627 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932236AbVKFENr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:13:47 -0500
Date: Sat, 5 Nov 2005 23:13:19 -0500
From: Dave Jones <davej@redhat.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: powernow-k8 schedules in atomic since sunday :-(
Message-ID: <20051106041319.GD4046@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Ashok Raj <ashok.raj@intel.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <436A34C5.2060108@vc.cvut.cz> <20051103124916.A29900@unix-os.sc.intel.com> <Pine.LNX.4.61.0511051643520.1526@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511051643520.1526@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:13:07PM -0800, Zwane Mwaikambo wrote:
 > On Thu, 3 Nov 2005, Ashok Raj wrote:
 > 
 > > On Thu, Nov 03, 2005 at 05:03:17PM +0100, Petr Vandrovec wrote:
 > > > Hello Ashok,
 > > >    your change '[PATCH] create and destroy cpufreq sysfs entries based on cpu 
 > > > notifiers' causes problems with powernow-k8 driver.  powernow-k8 uses 
 > > > set_cpus_allowed() (it even calls schedule() explicitly for no reason), and when 
 > > > you've changed code from lock_cpu_hotplug() to preempt_disable() 
 > > > set_cpus_allowed() now complains that schedule() is not allowed while preemption 
 > > > is disabled...
 > 
 > Hmm i submitted a patch 
 > (http://groups.google.ca/group/fa.linux.kernel/browse_frm/thread/ec079d77dc1f6e80/edf10a39eede6246?tvc=1&q=Remove+p$ 
 > to remove those superfluous schedules, but perhaps it hasn't hit Linus' 
 > tree yet via Davej.

I sent Linus a pull request last week, but I did it at the same
time osdl's mailserver had issues aparently.

I resent another request earlier this afternoon.

		Dave

