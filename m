Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVC1SGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVC1SGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVC1Rzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:55:32 -0500
Received: from mail.stdbev.com ([63.161.72.3]:3552 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S261986AbVC1Rxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:53:50 -0500
Message-ID: <f142907232cfa41a567366b414df53dc@stdbev.com>
Date: Mon, 28 Mar 2005 11:53:54 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Toshiba p35 laptop question
To: <linux-kernel@vger.kernel.org>
Reply-to: <jason@stdbev.com>
X-Mailer: Hastymail 1.4-CVS
x-priority: 3
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,
  I have a p35 Toshiba laptop running 2.6.12-rc1-mm3 and while I have
managed to get most things working it seems that much of the hardware is
not being recognized. For example:

root@jackass ~# lspci
0000:00:00.0 Host bridge: 
  ATI Technologies Inc: Unknown device 5831 (rev 02)
0000:00:01.0 PCI bridge: 
  ATI Technologies Inc: Unknown device 5838
0000:00:13.0 USB Controller: 
  ATI Technologies Inc: Unknown device 4347 (rev 01)
0000:00:13.1 USB Controller: 
  ATI Technologies Inc: Unknown device 4348 (rev 01)
0000:00:13.2 USB Controller: 
  ATI Technologies Inc: Unknown device 4345 (rev 01)
0000:00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 1a)
0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
0000:00:14.5 Multimedia audio controller: 
  ATI Technologies Inc IXP150 AC'97 Audio Controller (rev 01)
0000:00:14.6 Modem: ATI Technologies Inc: Unknown device 434d (rev 01)
0000:01:05.0 VGA compatible controller: 
  ATI Technologies Inc: Unknown device 5835
0000:02:00.0 FireWire (IEEE 1394): 
  VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
0000:02:02.0 Ethernet controller: 
  Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
0000:02:03.0 Ethernet controller: 
  Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:04.0 Cardroot@jackass ~# Bus bridge: 
  ENE Technology Inc CB710 Cardbus Controller
0000:02:04.1 FLASH memory: ENE Technology Inc: Unknown device 0530
0000:02:04.2 0805: ENE Technology Inc: Unknown device 0550
0000:02:04.3 FLASH memory: ENE Technology Inc: Unknown device 0520

Thats quite a few "unknown devices" :). I know this machine has an ATI
chipset but it seems that it may be a Toshiba-fied version. ACPI appears to
be "working" but the following seems problematic:

root@jackass ~#  dmesg | grep '^ACPI: No ACPI bus support' | wc -l
32

As does this snip from dmesg: 
ACPI-0294: *** Error: Looking up [STAT] in namespace, AE_ALREADY_EXISTS
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BIF] (Node dbf58300), AE_ALREADY_EXISTS
    ACPI-0294: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node dbf582e0), AE_ALREADY_EXISTS
SyncLink PC Card driver $Revision: 4.26 $

And doing a 'echo 3 > /proc/acpi/sleep' does absolutely nothing.

I guess my question is, is there anything I can do to improve the hardware
compatibility? I have tried a myriad of kernel options but nothing I do
seems to get any additional hardware recognized. Any suggestions are
appreciated.

attached is the lspci -vv output, dmesg, and kernel config for
2.6.12-rc1-mm3.

TIA

\__  Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/

