Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269537AbTGUJjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 05:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269542AbTGUJjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 05:39:35 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:57995 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S269537AbTGUJje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 05:39:34 -0400
Date: Mon, 21 Jul 2003 11:54:14 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: APIC support prevents power off
Message-ID: <20030721095414.GA3865@k3.hellgate.ch>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org, mingo@redhat.com
References: <200307210113.h6L1DqiY018985@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307210113.h6L1DqiY018985@harpo.it.uu.se>
X-Operating-System: Linux 2.6.0-test1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 03:13:52 +0200, Mikael Pettersson wrote:
> On Sun, 20 Jul 2003 16:36:13 +0200, Roger Luethi wrote:
> >On some UP boards (e.g. ASUS A7A266) enabling support for local APICs keeps
> >the machine from powering off on shutdown. It will just hang instead.
> >
> >This has been observed by others before [1]. A warning in the respective
> >configuration note seems in order (or a proper fix if anybody has one).
> 
> Insufficient data to draw anti-local-APIC conclusions.
> - ensure you have the latest BIOS

I tend not to touch the BIOS unless I have reason to believe an update will
fix an actual problem.

> - if you're using APM, ensure that CPU_IDLE and DISPLAY_BLANK are
>   disabled, and that APM isn't built as a module
>   (these things are known to cause APM hangs in UP APIC systems)
> - if you're using ACPI, try without ACPI, or at least with ACPI not
>   doing any power management

Your suggestions match my current configuration:

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI Support
#
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

> A very general "may break some BIOSen" warning could be in order.

Mentioning specific symptoms (like breaking power off) wouldn't hurt,
either.

Roger
