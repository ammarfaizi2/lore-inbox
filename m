Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbTG3LTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272005AbTG3LTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:19:09 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:13460 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271106AbTG3LTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:19:07 -0400
Date: Wed, 30 Jul 2003 13:19:05 +0200 (MEST)
Message-Id: <200307301119.h6UBJ5hU002233@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: core@enodev.com, linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU0: 02(02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 2003 20:23:22 -0500, Shawn <core@enodev.com> wrote:
>I just bought a shiny new Athlon 2400+ and popped it in my biostar M7VIB
>with an up to date bios.
>
>I'm running 2.6.0-test1-mm2, and I get tons of "APIC error on CPU0:
>02(02)" messages. Can someone tell me what is going on?

02 = Receive checksum error. Your APIC bus is corrupting messages
sent to the CPU. This is a serious hardware problem, indicating
that the board hasn't been properly designed for APIC usage.

First try to avoid using the APIC bus: disable SMP and UP_IOAPIC.
If your BIOS allows it, set interrupt mode to PIC not APIC.
If you still get these errors (but you shouldn't unless the HW
is _really_ broken), also disable UP_APIC.

Or replace the board with something better.
