Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTJGWL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 18:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTJGWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 18:11:29 -0400
Received: from aneto.able.es ([212.97.163.22]:13743 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262898AbTJGWL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 18:11:26 -0400
Date: Wed, 8 Oct 2003 00:11:24 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI64 bus vanished in 2.4.23-pre6
Message-ID: <20031007221124.GA7815@werewolf.able.es>
References: <20031007212727.GA3837@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031007212727.GA3837@werewolf.able.es> (from jamagallon@able.es on Tue, Oct 07, 2003 at 23:27:27 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.07, J.A. Magallon wrote:
> Hi all...
> 
> With 2.4.23-pre6, my e1000 cards did not work. I was thinking it was a driver
> problem, but the I realized that they are not even listed in lspci.
> 
> lspci (-n) in pre5:
> 
> 00:00.0 Class 0600: 1166:0009 (rev 06)
> 00:00.1 Class 0600: 1166:0009 (rev 06)
> 00:04.0 Class 0300: 1039:6326 (rev 0b)
> 00:06.0 Class 0200: 8086:1229 (rev 08)
> 00:0f.0 Class 0601: 1166:0200 (rev 51)
> 00:0f.1 Class 0101: 1166:0211
> 00:0f.2 Class 0c03: 1166:0220 (rev 04)
> 01:02.0 Class 0200: 8086:1004 (rev 02)
> 
> 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:04.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/
> 00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
> 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
> 01:02.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Co
> 
> lspci in pre6:
> 
> 00:00.0 Class 0600: 1166:0009 (rev 06)
> 00:00.1 Class 0600: 1166:0009 (rev 06)
> 00:04.0 Class 0300: 1039:6326 (rev 0b)
> 00:06.0 Class 0200: 8086:1229 (rev 08)
> 00:0f.0 Class 0601: 1166:0200 (rev 51)
> 00:0f.1 Class 0101: 1166:0211
> 00:0f.2 Class 0c03: 1166:0220 (rev 04)
> 
> 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:04.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/
> 00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
> 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
> 
> Do not know if it is a problem of the driver (i suppose it is not, the driver
> has nothing to do with lspci...), a problem of the bus number, a problem
> of the PCI bus being 64 bit, or a problem with the OSB4 chipset.
> 

Er, it looks like chipset specific. The front end has the very same card
(different mobo) on bus 3:

annwn:~> lspci
00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)
00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04)
00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 04)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1)
02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03)
03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01)
03:01.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Copper) (rev 02)
03:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
04:03.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
04:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)

???

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre6-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
