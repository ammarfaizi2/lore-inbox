Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbTHWRhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTHWRgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:36:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39585 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264953AbTHWReY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:34:24 -0400
Date: Sat, 23 Aug 2003 18:34:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Invalid PBLK length for athlon XP-M on Asus laptop
Message-ID: <20030823173423.GQ18834@parcelfarce.linux.theplanet.co.uk>
References: <20030823125812.GC913@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823125812.GC913@renditai.milesteg.arr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 02:58:12PM +0200, Daniele Venzano wrote:
> Since this is a laptop it seemed a bit strange to me 8), so I checked
> dmesg with acpi debugging turned on (full dmesg is attached), and I
> found these:
> 
> [.....]
> ACPI: Fan [FAN0] (on)
> acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]

This is a bug in your ACPI bios, you need a vendor update.  We tried
fixing this but it broke a number of laptops, so we had to revert it.

> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> acpi_processor_perf-0104 [28] acpi_processor_get_per: Unsupported address space [127] (control_register)
> cpufreq: No CPUs supporting ACPI performance management found.

That means that you need a non-acpi driver for perf throttling.  Did you
try enabling some of the other cpufreq drivers?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
