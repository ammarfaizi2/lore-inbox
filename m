Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTJGV1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTJGV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:27:36 -0400
Received: from aneto.able.es ([212.97.163.22]:12460 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262874AbTJGV1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:27:32 -0400
Date: Tue, 7 Oct 2003 23:27:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PCI64 bus vanished in 2.4.23-pre6
Message-ID: <20031007212727.GA3837@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

With 2.4.23-pre6, my e1000 cards did not work. I was thinking it was a driver
problem, but the I realized that they are not even listed in lspci.

lspci (-n) in pre5:

00:00.0 Class 0600: 1166:0009 (rev 06)
00:00.1 Class 0600: 1166:0009 (rev 06)
00:04.0 Class 0300: 1039:6326 (rev 0b)
00:06.0 Class 0200: 8086:1229 (rev 08)
00:0f.0 Class 0601: 1166:0200 (rev 51)
00:0f.1 Class 0101: 1166:0211
00:0f.2 Class 0c03: 1166:0220 (rev 04)
01:02.0 Class 0200: 8086:1004 (rev 02)

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:04.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/
00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:02.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Co

lspci in pre6:

00:00.0 Class 0600: 1166:0009 (rev 06)
00:00.1 Class 0600: 1166:0009 (rev 06)
00:04.0 Class 0300: 1039:6326 (rev 0b)
00:06.0 Class 0200: 8086:1229 (rev 08)
00:0f.0 Class 0601: 1166:0200 (rev 51)
00:0f.1 Class 0101: 1166:0211
00:0f.2 Class 0c03: 1166:0220 (rev 04)

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:04.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/
00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)

Do not know if it is a problem of the driver (i suppose it is not, the driver
has nothing to do with lspci...), a problem of the bus number, a problem
of the PCI bus being 64 bit, or a problem with the OSB4 chipset.

>From the changelog, my candidates are:

<moilanen:austin.ibm.com>:
  o Workaround PPC64 PCI scan issue

Len Brown:
  o [ACPI] ...

Any ideas ?
 
TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre6-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
