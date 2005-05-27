Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVE0VVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVE0VVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVE0VVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:21:13 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:16268 "EHLO
	mailwasher.lanl.gov") by vger.kernel.org with ESMTP id S262604AbVE0VUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:20:30 -0400
Message-ID: <42978F18.6010103@mesatop.com>
Date: Fri, 27 May 2005 15:20:24 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 0x29A (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: Build error without CONFIG_ACPI for current 2.6 git. (even with recent
 ACPI BUILD fix)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With current 2.6 (HEAD = 254feb882a7c6e4e51416dff6a97d847fbbba551 ),
I get this on x86 without CONFIG_ACPI:

arch/i386/kernel/built-in.o(.init.text+0x1a31): In function `setup_arch':
: undefined reference to `acpi_boot_table_init'
arch/i386/kernel/built-in.o(.init.text+0x1a36): In function `setup_arch':
: undefined reference to `acpi_boot_init'
make: *** [.tmp_vmlinux1] Error 1

Setting CONFIG_ACIP=y results in a successful build.

[steven@spc0 linux-2.6]$ grep ^CONFIG_ACPI .config
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

I checked that commit 8aadff7dd519800ce7c0e7fb75dcd4438b373134
had been applied, and drivers/acpi/Kconfig looks like it should with
that fix applied.

My incoming mail has been slow, so sorry if this was already
reported recently.

Steven
