Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWICMev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWICMev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWICMev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 08:34:51 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:32423
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750970AbWICMeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 08:34:50 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.18-rc5-mm1 -- bcm43xx: Out of DMA descriptor slots!
Date: Sun, 3 Sep 2006 14:33:49 +0200
User-Agent: KMail/1.9.4
References: <a44ae5cd0609030218y547e1c94pd7ba5337e1a27b2b@mail.gmail.com>
In-Reply-To: <a44ae5cd0609030218y547e1c94pd7ba5337e1a27b2b@mail.gmail.com>
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Larry Finger <Larry.Finger@lwfinger.net>, linville@tuxdriver.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609031433.49658.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 September 2006 11:18, Miles Lane wrote:
> Michael, I think this is related to your code (bcm43xx_dma.c).  It is
> quite possible that the bug isn't in your code, but rather in the
> general management of DMA.

Please try latest wireless-2.6 tree. I think it has a bugfix for this.

> bcm43xx: Out of DMA descriptor slots!
> SoftMAC: Scanning finished
> SoftMAC: Start scanning with channel: 1
> SoftMAC: Scanning 14 channels
> printk: 27 messages suppressed.
> bcm43xx: Out of DMA descriptor slots!
> SoftMAC: Scanning finished
> bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
> bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
> bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
> bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
> bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
> bcm43xx: Radio turned off
> bcm43xx: DMA 0x0200 (RX) max used slots: 0/64
> bcm43xx: DMA 0x0260 (TX) max used slots: 0/512
> bcm43xx: DMA 0x0240 (TX) max used slots: 0/512
> bcm43xx: DMA 0x0220 (TX) max used slots: 512/512
> bcm43xx: DMA 0x0200 (TX) max used slots: 0/512
> SoftMAC: Canceling existing associate request!
> SoftMAC: Associate: Scanning for networks first.
> SoftMAC: Associate: failed to initiate scan. Is device up?
> bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
> [NetworkManager:3749]: Changing netdevice name from [eth2] to [F]
> bcm43xx: PHY connected
> bcm43xx: Radio turned on
> bcm43xx: Chip initialized
> bcm43xx: DMA initialized
> bcm43xx: Keys cleared
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
> bcm43xx: Selected 802.11 core (phytype 2)
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
> SoftMAC: Associate: Scanning for networks first.
> SoftMAC: Start scanning with channel: 1
> SoftMAC: Scanning 14 channels
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
> ADDRCONF(NETDEV_UP): F: link is not ready
> bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
> drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
> dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port 67 interval 5
> dhclient: send_packet: No such device
> dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port 67 interval 11
> dhclient: send_packet: No such device
> NetworkManager: <WARNING>^I nm_device_802_11_wireless_get_mode ():
> error getting card mode on eth2: No such device
> NetworkManager: <WARNING>^I nm_device_802_11_wireless_scan (): could
> not trigger wireless scan on device eth2: No such device
> NetworkManager: <WARNING>^I nm_device_802_11_wireless_get_mode ():
> error getting card mode on eth2: No such device
> 

-- 
Greetings Michael.

-- 
VGER BF report: H 3.71389e-10
