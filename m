Return-Path: <linux-kernel-owner+w=401wt.eu-S932663AbXAJCZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXAJCZT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 21:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbXAJCZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 21:25:18 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:62278 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbXAJCZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 21:25:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a/sufKLZRx4jV8HW0dPZHsxIvvwMgbfCn8youFw7Zm3vQtWqPKZQeDRTl7LTKe3xKH59Ki2sAogVXdCpGss8KhQB/VUgnIQjGsaYw2MZ1SyFQ+yDHOcVOuXScV+Y2Np9hz4ZgeLUPrwQC1dsJloJbE+zoZjAPkH6D8CCUzdRn6w=
Message-ID: <d49e924d0701091825i7c4d7aa8h88dfec01141b3171@mail.gmail.com>
Date: Tue, 9 Jan 2007 18:25:16 -0800
From: "Vasudevan S" <savasude@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PCI BIOS Bug messages
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run Fedora Core 6 on the 'compaq nc6320' laptop. I am using the
'2.6.19.1' kernel.

While booting the kernel, I noticed the following error message:

PCI: BIOS Bug: MCFG area at f8000000 is not E820-reserved
PCI: Not using MMCONFIG.

After some search, I commented out the 'e820_all_mapped()' check in
the 'pci_mmcfg_init()' function. I no longer see this message and MMCONFIG
method seems to be used now.

Is this the right thing to do?

Thanks,
--Vasu

lspci output on this laptop:

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 01)
01:00.0 Network controller: Broadcom Corporation Dell Wireless 1390
WLAN Mini-PCI Card (rev 01)
04:06.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
04:06.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant
IEEE 1394 Host Controller
04:06.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia
Card Reader (SD/MMC/MS/MS PRO/xD)
04:06.3 Class 0805: Texas Instruments PCIxx12 SDA Standard Compliant
SD Host Controller
04:06.4 Communication controller: Texas Instruments PCIxx12 GemCore
based SmartCard controller
04:0e.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788
Gigabit Ethernet (rev 03)
