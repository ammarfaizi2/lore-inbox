Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbTGUA7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269124AbTGUA7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:59:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:14052 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S269030AbTGUA7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:59:05 -0400
Date: Mon, 21 Jul 2003 03:13:52 +0200 (MEST)
Message-Id: <200307210113.h6L1DqiY018985@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, rl@hellgate.ch
Subject: Re: APIC support prevents power off
Cc: mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003 16:36:13 +0200, Roger Luethi wrote:
>On some UP boards (e.g. ASUS A7A266) enabling support for local APICs keeps
>the machine from powering off on shutdown. It will just hang instead.
>
>This has been observed by others before [1]. A warning in the respective
>configuration note seems in order (or a proper fix if anybody has one).
>
>Roger
>
>[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105561164424871&w=2

Insufficient data to draw anti-local-APIC conclusions.
- ensure you have the latest BIOS
- if you're using APM, ensure that CPU_IDLE and DISPLAY_BLANK are
  disabled, and that APM isn't built as a module
  (these things are known to cause APM hangs in UP APIC systems)
- if you're using ACPI, try without ACPI, or at least with ACPI not
  doing any power management

A very general "may break some BIOSen" warning could be in order.

/Mikael
