Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSLaM4g>; Tue, 31 Dec 2002 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSLaM4g>; Tue, 31 Dec 2002 07:56:36 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:41459 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261317AbSLaM4f>;
	Tue, 31 Dec 2002 07:56:35 -0500
Date: Tue, 31 Dec 2002 14:05:00 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212311305.OAA13305@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, soppscum@online.no
Subject: Re: nmi_watchdog NMI count zero on a AMD K6-3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002 07:56:45 +0100 (MET), "Michael <soppscum@online.no>" wrote:
>With both nmi_watchdog=1/2 I get NMI: 0 in /proc/interrupts with a AMD K6-3

nmi_watchdog=2 will never do anything on a K6 since the K6s lack the
on-CPU local APIC and performance counter features needed for this mode.

nmi_watchdog=1 needs an I/O APIC and (for K6) an external local APIC.
That configuration is very unusual (it was used for pre-Pentium
multiprocessor systems).

Your machine is behaving as expected. If you need NMI watchdog support
you'll have to find or add some other programmable NMI source.

/Mikael
