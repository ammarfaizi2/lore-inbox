Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbTJVHT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 03:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTJVHT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 03:19:29 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:58981 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263306AbTJVHTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 03:19:03 -0400
Date: Wed, 22 Oct 2003 09:18:57 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: arjanv@redhat.com, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPIP-state driver
Message-ID: <20031022091857.A25963@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D3720017304B031@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7F740D512C7C1046AB53446D3720017304B031@scsmsx402.sc.intel.com>; from jun.nakajima@intel.com on Tue, Oct 21, 2003 at 08:47:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 08:47:51AM -0700, Nakajima, Jun wrote:
> > 
> > it's all nice code and such, but I still wonder why this can't be done
> > by a userland policy daemon. The 2.6 kernel has the infrastructure to
> > give very detailed information to userspace (eg top etc) about idle
> > percentages...... I didn't see anything in this driver that couldn't
> be
> > done from userspace.
> > 
> 
> It's about the frequency of the feedback loop. As we have much lower
> latency with P-state transitions, the sampling time can be order of
> millisecond (or shorter if meaningful). A userland daemon can have a
> high-level policy (preferences, or set of parameters), but it cannot be
> part of the real feedback loop. If we combine P-state transitions and
> deeper C-state transitions, the situation is worse with a userland
> daemon.


As I said the CURRENT code doesn't seem to do that. I can see the use of
in kernel hooks in to thigs; for example the scheduler could do an upcall
to the cpufreq core if a task uses it's timeslice completely (which would
be a sign that things need to go to a higher speed). I'd be very
interested to see things like that.
