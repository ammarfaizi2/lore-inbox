Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270303AbUJTVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270303AbUJTVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUJTVEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:04:44 -0400
Received: from fmr10.intel.com ([192.55.52.30]:55508 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S269038AbUJTVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:03:58 -0400
Subject: Re: [PATCH] cpufreq_ondemand
From: Len Brown <len.brown@intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Andre Eisenbach <int2str@gmail.com>,
       Alexander Clouter <alex-kernel@digriz.org.uk>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       "cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
In-Reply-To: <20041020143057.GA7652@dominikbrodowski.de>
References: <7f800d9f04101922031be5cfe8@mail.gmail.com>
	 <1098257735.26595.4308.camel@d845pe>
	 <20041020143057.GA7652@dominikbrodowski.de>
Content-Type: text/plain
Organization: 
Message-Id: <1098306225.26605.4345.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 17:03:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 10:30, Dominik Brodowski wrote:
> On Wed, Oct 20, 2004 at 03:35:35AM -0400, Len Brown wrote:

> > The question is what POLICY we're trying to implement.
> 
> This is why there may be DIFFERENT policies a.k.a. governors in
> cpufreq.
....
> 
> Put it in userspace, and let it ask the cpufreq core in the kernel to
> use a specific governor or another depending on what you want. That's
> what certain userspace daemons / scripts already do, btw.

Processors are not the only devices with power management.  When a
device driver, say USB, or any ACPI or PCI power-managed device,
recognizes that its device is idle, who does it ask to find out what
power state to put the hardware in?  Today there is nobody to tell it
what to do.

The user's global desired power policy needs to be represented in the
kernel where all devices can get at it so they can make low-latency
policy-based decisions.  It isn't clear that the cpufreq multiple
governor implementation model would work well for the system as whole.

-Len


