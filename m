Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWC3CAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWC3CAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWC3CAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:00:52 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:37819 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751433AbWC3CAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:00:51 -0500
Date: Thu, 30 Mar 2006 04:00:48 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com
Subject: [2.6.16-gitX] (x86_64) WARNING: drivers/acpi/processor.o - Section
 mismatch...
Message-Id: <20060330040048.5ffdadcb.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Git versions keep incrementing but no fix for:

  BUILD   arch/x86_64/boot/bzImage
Root device is (3, 2)
Boot sector 512 bytes.
Setup is 4696 bytes.
System is 1530 kB
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data:
from .text between 'acpi_processor_power_init' (at offset 0x1495) and
'acpi_processor_power_exit'
  CC      arch/x86_64/kernel/cpufreq/powernow-k8.mod.o
  LD [M]  arch/x86_64/kernel/cpufreq/powernow-k8.ko

Has been like that since "kbuild: check for section mismatch during
modpost stage" went in to catch these things. AKA:

b39927cf4cc5a9123d2b157ffd396884cb8156eb

Mvh
Mats Johannesson
--
