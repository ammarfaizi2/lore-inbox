Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSJ1H6T>; Mon, 28 Oct 2002 02:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbSJ1H6T>; Mon, 28 Oct 2002 02:58:19 -0500
Received: from dp.samba.org ([66.70.73.150]:51921 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263105AbSJ1H6R>;
	Mon, 28 Oct 2002 02:58:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, mingo@redhat.com, mochel@osdl.org
Subject: [PATCH] Hotplug CPUs for i386 2.5.44 
Date: Mon, 28 Oct 2002 19:04:15 +1100
Message-Id: <20021028080437.DE7112C0E3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't apply to -mm5 because someone did wierd things with the CPU
placement in driverfs, which clashes with this patch which moves it to
kernel/cpu.c...

Usage:
1) Apply patch, and boot resulting kernel.
2) echo 0 > /devices/root/sys/cpu0/online
3) echo 1 > /devices/root/sys/cpu0/online

The CPU actually spins with interrupts off, doing cpu_relax() and
polling a variable.  It's basically useful for testing the unplug
infrastructure and benchmarking.

http://www.kernel.org/pub/linux/kernel/people/rusty/patches/hotcpu-x86-28-10-2002.2.5.44.diff.gz

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
