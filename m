Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUJTV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUJTV0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJTVWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:22:42 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:5058 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S267951AbUJTVVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:21:36 -0400
Date: Wed, 20 Oct 2004 23:18:51 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Len Brown <len.brown@intel.com>
Cc: Andre Eisenbach <int2str@gmail.com>,
       Alexander Clouter <alex-kernel@digriz.org.uk>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       "cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041020211851.GA7569@dominikbrodowski.de>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	Andre Eisenbach <int2str@gmail.com>,
	Alexander Clouter <alex-kernel@digriz.org.uk>,
	linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
	"cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
References: <7f800d9f04101922031be5cfe8@mail.gmail.com> <1098257735.26595.4308.camel@d845pe> <20041020143057.GA7652@dominikbrodowski.de> <1098306225.26605.4345.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098306225.26605.4345.camel@d845pe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 05:03:45PM -0400, Len Brown wrote:
> On Wed, 2004-10-20 at 10:30, Dominik Brodowski wrote:
> > On Wed, Oct 20, 2004 at 03:35:35AM -0400, Len Brown wrote:
> 
> > > The question is what POLICY we're trying to implement.
> > 
> > This is why there may be DIFFERENT policies a.k.a. governors in
> > cpufreq.
> ....
> > 
> > Put it in userspace, and let it ask the cpufreq core in the kernel to
> > use a specific governor or another depending on what you want. That's
> > what certain userspace daemons / scripts already do, btw.
> 
> Processors are not the only devices with power management.  When a
> device driver, say USB, or any ACPI or PCI power-managed device,
> recognizes that its device is idle, who does it ask to find out what
> power state to put the hardware in?  Today there is nobody to tell it
> what to do.

Something like sysfs' "detach_state" comes to my mind...

> The user's global desired power policy needs to be represented in the
> kernel where all devices can get at it so they can make low-latency
> policy-based decisions.  It isn't clear that the cpufreq multiple
> governor implementation model would work well for the system as whole.

The question is how much policy we want in the kernel instead of in
userspace. The actual implementation (i.e. fast transitions to idle states)
must be in the kernel, of course. However the policy decision of whether to
do such idling can and IMHO should be done in userspace.

My $0.02,

	Dominik
