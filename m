Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266765AbUGLJUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266765AbUGLJUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 05:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUGLJUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 05:20:50 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:46978 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S266765AbUGLJUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 05:20:20 -0400
Date: Mon, 12 Jul 2004 11:20:14 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Toshiba keyboard lockups
Message-ID: <20040712092014.GE29244@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <40A162BA.90407@sun.com> <200405121149.37334.rjwysocki@sisk.pl> <40C7880C.4000401@sun.com> <200406101915.i5AJFCBu197611@car.linuxhacker.ru> <efc4b1ba19898906eb0aec7ac9c22fcd@stdbev.com> <40C8DB38.9030300@sun.com> <20040706084800.GU19374@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040706084800.GU19374@charite.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> When I added the debugging/callback trace code I got:

Today I had to type A LOT on the keyboard while being on the fb-console.
This time I got useful stacktraces:

...
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
spurious 8259A interrupt: IRQ7.
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<c01f25d4>] ide_dma_intr+0x78/0x95
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<d1064f24>] rm_isr+0x24/0x30 [nvidia]
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<d1064f24>] rm_isr+0x24/0x30 [nvidia]
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<d1064f24>] rm_isr+0x24/0x30 [nvidia]
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
Stack pointer is garbage, not printing trace
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<d1064f24>] rm_isr+0x24/0x30 [nvidia]
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
 [<c020b4e6>] serio_queue_event+0x91/0x93
 [<c020f0fb>] atkbd_interrupt+0x458/0x59e
 [<d1064f24>] rm_isr+0x24/0x30 [nvidia]
 [<c020be5f>] serio_interrupt+0x2c/0x6a
 [<c020c32a>] i8042_interrupt+0x86/0xf7
 [<c0105aa0>] handle_IRQ_event+0x2e/0x50
 [<c0105d95>] do_IRQ+0xb0/0x14b
 =======================
 [<c0104550>] common_interrupt+0x18/0x20
 [<d0c1023a>] acpi_processor_idle+0xd4/0x1c7 [processor]
 [<c010209b>] cpu_idle+0x2c/0x35
 [<c0335668>] start_kernel+0x135/0x14e
 [<c033530b>] unknown_bootoption+0x0/0x144
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
Stack pointer is garbage, not printing trace
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
Stack pointer is garbage, not printing trace
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
Stack pointer is garbage, not printing trace
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
Stack pointer is garbage, not printing trace
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: RESCAN || RECONNECT requested: 0!
Stack pointer is garbage, not printing trace
input: AT Translated Set 2 keyboard on isa0060/serio0

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
