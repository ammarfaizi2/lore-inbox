Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWICJSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWICJSd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 05:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWICJSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 05:18:33 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:39053 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750986AbWICJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 05:18:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J6oSOm/TYPwOFrxHL+UbyMxNtgNcpsZMe8bF8HhfROLoULJyByO4d/7obdyu0WoAEEOc4K7dxtGxEj7iZIu1BegCwJxWxhiLpjQX0HV+v4mOUo+7GY2nmPB58O0d1Qi0VL7RwsdV3ySlVvhPgEZjA3Tb2E4/4MGsgCDxUVI/DNY=
Message-ID: <a44ae5cd0609030218y547e1c94pd7ba5337e1a27b2b@mail.gmail.com>
Date: Sun, 3 Sep 2006 02:18:31 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Michael Buesch" <mbuesch@freenet.de>
Subject: 2.6.18-rc5-mm1 -- bcm43xx: Out of DMA descriptor slots!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, I think this is related to your code (bcm43xx_dma.c).  It is
quite possible that the bug isn't in your code, but rather in the
general management of DMA.

bcm43xx: Out of DMA descriptor slots!
SoftMAC: Scanning finished
SoftMAC: Start scanning with channel: 1
SoftMAC: Scanning 14 channels
printk: 27 messages suppressed.
bcm43xx: Out of DMA descriptor slots!
SoftMAC: Scanning finished
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
bcm43xx: Radio turned off
bcm43xx: DMA 0x0200 (RX) max used slots: 0/64
bcm43xx: DMA 0x0260 (TX) max used slots: 0/512
bcm43xx: DMA 0x0240 (TX) max used slots: 0/512
bcm43xx: DMA 0x0220 (TX) max used slots: 512/512
bcm43xx: DMA 0x0200 (TX) max used slots: 0/512
SoftMAC: Canceling existing associate request!
SoftMAC: Associate: Scanning for networks first.
SoftMAC: Associate: failed to initiate scan. Is device up?
bcm43xx: set security called, .level = 0, .enabled = 0, .encrypt = 0
[NetworkManager:3749]: Changing netdevice name from [eth2] to [F]
bcm43xx: PHY connected
bcm43xx: Radio turned on
bcm43xx: Chip initialized
bcm43xx: DMA initialized
bcm43xx: Keys cleared
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
bcm43xx: Selected 802.11 core (phytype 2)
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
SoftMAC: Associate: Scanning for networks first.
SoftMAC: Start scanning with channel: 1
SoftMAC: Scanning 14 channels
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2240:bcm43xx_mac_enable()
ADDRCONF(NETDEV_UP): F: link is not ready
bcm43xx: ASSERTION FAILED (bcm->mac_suspended >= 0) at:
drivers/net/wireless/bcm43xx/bcm43xx_main.c:2258:bcm43xx_mac_suspend()
dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port 67 interval 5
dhclient: send_packet: No such device
dhclient: DHCPDISCOVER on eth2 to 255.255.255.255 port 67 interval 11
dhclient: send_packet: No such device
NetworkManager: <WARNING>^I nm_device_802_11_wireless_get_mode ():
error getting card mode on eth2: No such device
NetworkManager: <WARNING>^I nm_device_802_11_wireless_scan (): could
not trigger wireless scan on device eth2: No such device
NetworkManager: <WARNING>^I nm_device_802_11_wireless_get_mode ():
error getting card mode on eth2: No such device

-- 
VGER BF report: U 0.501222
