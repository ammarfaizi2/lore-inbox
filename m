Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265325AbSLPGSJ>; Mon, 16 Dec 2002 01:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSLPGSJ>; Mon, 16 Dec 2002 01:18:09 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:59445
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265325AbSLPGSI>; Mon, 16 Dec 2002 01:18:08 -0500
Date: Mon, 16 Dec 2002 01:28:35 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Scott Robert Ladd <scott@coyotegulch.com>
cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: /proc/cpuinfo and hyperthreading
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJEEKADLAA.scott@coyotegulch.com>
Message-ID: <Pine.LNX.4.50.0212160126110.12535-100000@montezuma.mastecende.com>
References: <FKEAJLBKJCGBDJJIPJLJEEKADLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002, Scott Robert Ladd wrote:

> But later in the boot, it also states:
>
> Dec 15 11:51:18 Tycho kernel: SMP motherboard not detected.
>
> Something just doesn't look right about this.

Thats just the MP table parsing code whining. Which is ok since you're
using ACPI... hmm then again...

if (!smp_found_config) {
                printk(KERN_NOTICE "SMP motherboard not detected.\n");
                smpboot_clear_io_apic_irqs();
                phys_cpu_present_map = 1;
                if (APIC_init_uniprocessor())


-- 
function.linuxpower.ca
