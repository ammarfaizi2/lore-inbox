Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUJTPSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUJTPSe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUJTPO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:14:58 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:25806 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S267866AbUJTPIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:08:00 -0400
Date: Wed, 20 Oct 2004 16:30:57 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Len Brown <len.brown@intel.com>
Cc: Andre Eisenbach <int2str@gmail.com>,
       Alexander Clouter <alex-kernel@digriz.org.uk>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       "cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041020143057.GA7652@dominikbrodowski.de>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	Andre Eisenbach <int2str@gmail.com>,
	Alexander Clouter <alex-kernel@digriz.org.uk>,
	linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
	"cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
References: <7f800d9f04101922031be5cfe8@mail.gmail.com> <1098257735.26595.4308.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098257735.26595.4308.camel@d845pe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:35:35AM -0400, Len Brown wrote:
> On Wed, 2004-10-20 at 01:03, Andre Eisenbach wrote:
> 
> > ... If the
> > speed steps down slowly but shoots up 100% quickly (as it is right
> > now), even a small task (like opening a folder, or scrolling down in a
> > document) will cause a tiny spike to 100% which takes a while to go
> > back down. The result is that the CPU spends most of it's time at 100%
> > or calming down. I wrote a small test program on my notebook which
> > confirms this.
> 
> The question is what POLICY we're trying to implement.

This is why there may be DIFFERENT policies a.k.a. governors in cpufreq.

>  If the goal is
> to to be energy efficient while the user notices no performance hit,
> then fast-up/slow-down is an EXCELLENT strategy.  But if the goal is to
> optimize for power savings at the cost of impacting performance, then
> another strategy may work better.

> The point is that no strategy will be optimal for all policies.  Linux
> needs a global power policy manager that the rest of the system can ask
> about the current policy.  This way sub-systems can (automatically)
> implement whatever local strategies are consistent with that global
> policy.

Put it in userspace, and let it ask the cpufreq core in the kernel to use a
specific governor or another depending on what you want. That's what certain
userspace daemons / scripts already do, btw.

	Dominik
