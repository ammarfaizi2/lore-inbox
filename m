Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWBES23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWBES23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 13:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWBES22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 13:28:28 -0500
Received: from mail.gmx.de ([213.165.64.21]:38581 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750863AbWBES22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 13:28:28 -0500
X-Authenticated: #7534793
Date: Sun, 5 Feb 2006 19:06:35 +0100
From: Gerhard Schrenk <deb.gschrenk@gmx.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi_cpufreq broken after _PDC patch
Message-ID: <20060205180635.GB4340@mailhub.uni-konstanz.de>
References: <88056F38E9E48644A0F562A38C64FB60072481C8@scsmsx403.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60072481C8@scsmsx403.amr.corp.intel.com>
User-Agent: mutt-ng/devel-r655 (Debian)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> [2006-02-04 22:41]:

> You need to configure X86_SPEEDSTEP_CENTRINO_ACPI as well. That is
> required to make speedstep-centrino work with ACPI.

Yes. Thanks. This option was masked by it's strange dependency

(...) && (X86_SPEEDSTEP_CENTRINO!=y || ACPI_PROCESSOR!=m)

Unfortunately I had exactly this configuration. Now with
ACPI_PROCESSOR=y the speedstep-centrino driver works for me *much* better
than acpi-cpufreq! So no need for acpi-cpufreq driver here any more.

Besides it's better frequency scaling the main advantage for *me* over
acpi-cpufreq is that it works without any problem as statically compiled
driver. Now the sole obstacle on my way to a monolithic/static kernel
remains CONFIG_IPW2200=m.

Many thanks for your help
-- Gerhard
