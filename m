Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbSJGNVu>; Mon, 7 Oct 2002 09:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263024AbSJGNVu>; Mon, 7 Oct 2002 09:21:50 -0400
Received: from h-64-105-137-52.SNVACAID.covad.net ([64.105.137.52]:13440 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263027AbSJGNVs>; Mon, 7 Oct 2002 09:21:48 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 7 Oct 2002 06:27:19 -0700
Message-Id: <200210071327.GAA00711@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.40 64GB highmem BUG()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Although 2.5.40 has been out for a while, I think I ought
to post this bug as I haven't seen any other mention of it.

	When I boot an 2.5.40 x86 kernel built with CONFIG_HIGHMEM64G,
and with a 920kB initial ramdisk (2.2MB uncompressed), I get a kernel
BUG() at highmem.c line 480, preceded by a message saying "scheduling
with KM_TYPE 15 held!"  The machine on which I experienced this
problem has 1.25GB of RAM.  The problem occurs with and without
CONFIG_PREEMPT.  All kernels that tried were SMP kernels running on a
uniprocessor.

	The problem does not occur if I build 2.5.40 with
CONFIG_HIGHMEM4G or CONFIG_NOHIGMEM.  So, it's probably not causing
problems for many people, but I thought I should report it anyhow.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
