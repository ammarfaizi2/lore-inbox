Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVC1Sp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVC1Sp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVC1Sp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:45:56 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:37138 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261986AbVC1Spo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:45:44 -0500
Date: Mon, 28 Mar 2005 20:45:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jason Munro <jason@stdbev.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Toshiba p35 laptop question (2)
Message-Id: <20050328204543.4924a4ff.khali@linux-fr.org>
In-Reply-To: <e36da76c0bdd26fda4a98624be369f48@stdbev.com>
References: <e36da76c0bdd26fda4a98624be369f48@stdbev.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, 

> Everyone,
>   I have a p35 Toshiba laptop running 2.6.12-rc1-mm3 and while I have
> managed to get most things working it seems that much of the hardware
> is not being recognized. For example:
> 
> root@jackass ~# lspci
> 0000:00:00.0 Host bridge:
>   ATI Technologies Inc: Unknown device 5831 (rev 02)
> 0000:00:01.0 PCI bridge:
>   ATI Technologies Inc: Unknown device 5838
> 0000:00:13.0 USB Controller:
>   ATI Technologies Inc: Unknown device 4347 (rev 01)
> 0000:00:13.1 USB Controller:
>   ATI Technologies Inc: Unknown device 4348 (rev 01)
> 0000:00:13.2 USB Controller:
>   ATI Technologies Inc: Unknown device 4345 (rev 01)
> 0000:00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 1a)
> 0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4349
> 0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 434c
> 0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4342
> 0000:00:14.5 Multimedia audio controller:
>   ATI Technologies Inc IXP150 AC'97 Audio Controller (rev 01)
> 0000:00:14.6 Modem: ATI Technologies Inc: Unknown device 434d (rev 01)
> 0000:01:05.0 VGA compatible controller:
>   ATI Technologies Inc: Unknown device 5835
> 0000:02:00.0 FireWire (IEEE 1394):
>   VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
> 0000:02:02.0 Ethernet controller:
>   Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
> 0000:02:03.0 Ethernet controller:
>   Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 0000:02:04.0 Cardroot@jackass ~# Bus bridge:
>   ENE Technology Inc CB710 Cardbus Controller
> 0000:02:04.1 FLASH memory: ENE Technology Inc: Unknown device 0530
> 0000:02:04.2 0805: ENE Technology Inc: Unknown device 0550
> 0000:02:04.3 FLASH memory: ENE Technology Inc: Unknown device 0520
> 
> Thats quite a few "unknown devices" :).

All it means is that your PCI device base is older than your laptop. See
http://pciids.sourceforge.net/. There you can check the online database
and download an updated pci.ids file to copy to (typically) /usr/share.
After that lspci might know more.

Hope that helps,
-- 
Jean Delvare
