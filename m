Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSKGS1n>; Thu, 7 Nov 2002 13:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSKGS1n>; Thu, 7 Nov 2002 13:27:43 -0500
Received: from fmr01.intel.com ([192.55.52.18]:61648 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261374AbSKGS1k>;
	Thu, 7 Nov 2002 13:27:40 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: swsusp: don't eat ide disks 
Date: Thu, 7 Nov 2002 10:26:59 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Woodhouse [mailto:dwmw2@infradead.org] 
> Why /proc/acpi/sleep ?
> 
> Other PM implementations gave us /proc/sys/pm/suspend -- why 
> doesn't ACPI 
> use that?
> 
> The stuff in /proc/acpi should be ACPI-specific. Anything 
> _generic_ like 
> battery info, sleep states, etc. should have a generic 
> interface which can 
> be used by any implementation. 

Yes, ACPI can and should use standard kernel interfaces when they are
available. The interfaces you're talking about don't exist yet, but could be
added.

An example of this is cpufreq. ACPI exposed its own proc interface before
cpufreq was integrated, but now it recently started working through cpufreq.
It should be relatively easy to establish generic interfaces for other areas
and hook ACPI into them.

Regards -- Andy
