Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVKLX0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVKLX0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVKLX0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:26:40 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:62700 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964853AbVKLX0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:26:40 -0500
Message-ID: <43767A2E.7000009@rtr.ca>
Date: Sat, 12 Nov 2005 18:26:38 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.6.15-rc1: ipw2200 still not working
Content-Type: multipart/mixed;
 boundary="------------090506090102070201090900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090506090102070201090900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Well, okay, the ipw2200 works fine if I turn off all security on the AP,
but the 2.6.15-rc1 version can no longer connect to my WPA/WPA2 network.

The same driver version out-of-tree works fine on 2.6.13,
but not on 2.6.14, nor in-tree with 2.6.15-rc1.

The syslog shows:

 >ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
 >ipw2200: Copyright(c) 2003-2005 Intel Corporation
 >...
 >eth1: NETDEV_TX_BUSY returned; driver should report queue full via ieee_device->is_queue_full.
 >...
 >ipw2200: U ipw_best_network Network 'RTR (00:13:46:16:96:b8)' excluded because of privacy mismatch: off != on.

That last message shows why it couldn't connect ("RTR" is my WPA-enabled AP),
but that's more of a symptom than the underlying problem.

Full debug trace attached

Cheers

--------------090506090102070201090900
Content-Type: text/x-log;
 name="wireless.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wireless.log"

Nov 12 18:21:58 localhost kernel: ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
Nov 12 18:21:58 localhost kernel: ipw2200: Copyright(c) 2003-2005 Intel Corporation
Nov 12 18:21:58 localhost kernel: ieee80211: U alloc_ieee80211 Initializing...
Nov 12 18:21:58 localhost kernel: ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 17 (level, low) -> IRQ 18
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_pci_probe pci_resource_len = 0x00001000
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_pci_probe pci_resource_base = f8b6c000
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_sw_reset Hardware crypto [on]
Nov 12 18:21:58 localhost kernel: ipw2200: Detected Intel PRO/Wireless 2915ABG Network Connection
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_get_fw Loading firmware 'ipw-2.4-boot.fw' file v2.0 (6464 bytes)
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_get_fw Loading firmware 'ipw-2.4-bss_ucode.fw' file v2.0 (16326 bytes)
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_get_fw Loading firmware 'ipw-2.4-bss.fw' file v2.0 (168336 bytes)
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_load initial device response after 10ms
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_stop_master stop master 0ms
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_load_ucode Microcode OK, rev. 53594 (0xd15a) dev. 3 (0x3) of 11/22/04 20:27
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_load device response after 50ms
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_eeprom_init_sram Writing EEPROM data into SRAM
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_up Geography 003 [ZZA] detected.
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_send_cmd TX_POWER command (#35) 76 bytes: 0x00000003
Nov 12 18:21:58 localhost kernel: 00000000 0B 02 01 14 02 14 03 14  04 14 05 14 06 14 07 14   ........ ........
Nov 12 18:21:58 localhost kernel: 00000010 08 14 09 14 0A 14 0B 14  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000040 00 00 00 00 00 00 00 00  00 00 00 00               ........ ....    
Nov 12 18:21:58 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_send_cmd TX_POWER command (#35) 76 bytes: 0x00000003
Nov 12 18:21:58 localhost kernel: 00000000 0B 01 01 14 02 14 03 14  04 14 05 14 06 14 07 14   ........ ........
Nov 12 18:21:58 localhost kernel: 00000010 08 14 09 14 0A 14 0B 14  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000040 00 00 00 00 00 00 00 00  00 00 00 00               ........ ....    
Nov 12 18:21:58 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_send_cmd TX_POWER command (#35) 76 bytes: 0x00000003
Nov 12 18:21:58 localhost kernel: 00000000 0D 00 24 14 28 14 2C 14  30 14 34 14 38 14 3C 14   ..$.(.,. 0.4.8.<.
Nov 12 18:21:58 localhost kernel: 00000010 40 14 95 14 99 14 9D 14  A1 14 A5 14 00 00 00 00   @....... ........
Nov 12 18:21:58 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:58 localhost kernel: 00000040 00 00 00 00 00 00 00 00  00 00 00 00               ........ ....    
Nov 12 18:21:58 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:58 localhost postfix/postfix-script: fatal: the Postfix mail system is not running
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_send_adapter_address eth1: Setting MAC to 00:12:f0:4a:63:6e
Nov 12 18:21:58 localhost logger: /usr/local/bin/dhclient3: -r -pf /var/run/dhclient.eth0.pid -lf /var/run/dhclient.eth0.leases eth0
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_send_cmd ADAPTER_ADDRESS command (#11) 6 bytes: 0x00000003
Nov 12 18:21:58 localhost dhclient: Internet Systems Consortium DHCP Client V3.0.1
Nov 12 18:21:58 localhost kernel: 00000000 00 12 F0 4A 63 6E                                  ...Jcn           
Nov 12 18:21:58 localhost dhclient: Copyright 2004 Internet Systems Consortium.
Nov 12 18:21:58 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:58 localhost dhclient: All rights reserved.
Nov 12 18:21:58 localhost kernel: ipw2200: U ipw_send_cmd SYSTEM_CONFIG command (#6) 20 bytes: 0x00000003
Nov 12 18:21:58 localhost dhclient: For info, please visit http://www.isc.org/products/DHCP
Nov 12 18:21:59 localhost kernel: 00000000 01 00 00 00 01 00 01 00  01 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost dhclient: 
Nov 12 18:21:59 localhost kernel: 00000010 00 00 01 00                                        ....             
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost dhclient: Listening on LPF/eth0/00:11:43:7a:5a:b9
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd SUPPORTED_RATES command (#22) 16 bytes: 0x00000003
Nov 12 18:21:59 localhost dhclient: Sending on   LPF/eth0/00:11:43:7a:5a:b9
Nov 12 18:21:59 localhost kernel: 00000000 02 0C 01 00 82 84 0B 16  0C 12 18 24 30 48 60 6C   ........ ...$0H`l
Nov 12 18:21:59 localhost dhclient: Sending on   Socket/fallback
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost dhclient: DHCPRELEASE on eth0 to 10.0.0.2 port 67
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd RTS_THRESHOLD command (#15) 4 bytes: 0x00000003
Nov 12 18:21:59 localhost kernel: 00000000 00 09 00 00                                        ....             
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd SEED_NUMBER command (#34) 4 bytes: 0x00000003
Nov 12 18:21:59 localhost kernel: 00000000 E4 AD C9 AD                                        ....             
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd HOST_COMPLETE command (#2) 0 bytes: 0x00000003
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_up Configured device on count 0
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd SCAN_REQUEST_EXT command (#26) 96 bytes: 0x00000023
Nov 12 18:21:59 localhost kernel: 00000000 00 00 00 00 0D 24 28 2C  30 34 38 3C 40 95 99 9D   .....$(, 048<@...
Nov 12 18:21:59 localhost logger: /usr/local/bin/dhclient3: -pf /var/run/dhclient.eth1.pid -lf /var/run/dhclient.eth1.leases eth1
Nov 12 18:21:59 localhost kernel: 00000010 A1 A5 4B 01 02 03 04 05  06 07 08 09 0A 0B 00 00   ..K..... ........
Nov 12 18:21:59 localhost dhclient: Internet Systems Consortium DHCP Client V3.0.1
Nov 12 18:21:59 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost dhclient: Copyright 2004 Internet Systems Consortium.
Nov 12 18:21:59 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 03 33 31 11 13 33   ........ ...31..3
Nov 12 18:21:59 localhost dhclient: All rights reserved.
Nov 12 18:21:59 localhost kernel: 00000040 33 03 33 33 33 33 33 00  00 00 00 00 00 00 00 00   3.33333. ........
Nov 12 18:21:59 localhost dhclient: For info, please visit http://www.isc.org/products/DHCP
Nov 12 18:21:59 localhost kernel: 00000050 00 00 00 00 00 00 00 00  78 00 00 00 14 00 14 00   ........ x.......
Nov 12 18:21:59 localhost dhclient: 
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_range GET Range
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_set_wap Setting AP BSSID to ANY
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_set_wap Attempting to associate with new parameters.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_associate Not attempting association (scanning or not initialized)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 20 (104 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification TODO: Calibration
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 36
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 40
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 44
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 48
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 52
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_range GET Range
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_txpow GET TX Power -> ON 20 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd TX_POWER command (#35) 76 bytes: 0x80200023
Nov 12 18:21:59 localhost kernel: 00000000 0B 02 01 14 02 14 03 14  04 14 05 14 06 14 07 14   ........ ........
Nov 12 18:21:59 localhost kernel: 00000010 08 14 09 14 0A 14 0B 14  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000040 00 00 00 00 00 00 00 00  00 00 00 00               ........ ....    
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd TX_POWER command (#35) 76 bytes: 0x80200023
Nov 12 18:21:59 localhost kernel: 00000000 0B 01 01 14 02 14 03 14  04 14 05 14 06 14 07 14   ........ ........
Nov 12 18:21:59 localhost kernel: 00000010 08 14 09 14 0A 14 0B 14  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000040 00 00 00 00 00 00 00 00  00 00 00 00               ........ ....    
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_send_cmd TX_POWER command (#35) 76 bytes: 0x80200023
Nov 12 18:21:59 localhost kernel: 00000000 0D 00 24 14 28 14 2C 14  30 14 34 14 38 14 3C 14   ..$.(.,. 0.4.8.<.
Nov 12 18:21:59 localhost kernel: 00000010 40 14 95 14 99 14 9D 14  A1 14 A5 14 00 00 00 00   @....... ........
Nov 12 18:21:59 localhost kernel: 00000020 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000030 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........ ........
Nov 12 18:21:59 localhost kernel: 00000040 00 00 00 00 00 00 00 00  00 00 00 00               ........ ....    
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_irq_tasklet Command completed.
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_name Name: unassociated
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_freq GET Freq/Channel -> 0 
Nov 12 18:21:59 localhost kernel: ieee80211: U ieee80211_wx_get_encode GET_ENCODE
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_essid Getting essid: ANY
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_mode Get MODE -> 2
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_range GET Range
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_wap Getting WAP BSSID: 00:00:00:00:00:00
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_nick Getting nick
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_rate GET Rate -> 0 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_rts GET RTS Threshold -> 2304 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_frag GET Frag Threshold -> 2346 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_power GET Power Management Mode -> 06
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_txpow GET TX Power -> ON 20 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_retry GET retry -> 7 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_name Name: unassociated
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_freq GET Freq/Channel -> 0 
Nov 12 18:21:59 localhost kernel: ieee80211: U ieee80211_wx_get_encode GET_ENCODE
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_essid Getting essid: ANY
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_mode Get MODE -> 2
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_range GET Range
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_wap Getting WAP BSSID: 00:00:00:00:00:00
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_nick Getting nick
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_rate GET Rate -> 0 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_rts GET RTS Threshold -> 2304 
Nov 12 18:21:59 localhost hald[6916]: Timed out waiting for hotplug event 1121. Rebasing to 1131
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_frag GET Frag Threshold -> 2346 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_power GET Power Management Mode -> 06
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_txpow GET TX Power -> ON 20 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_retry GET retry -> 7 
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 56
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_net_open dev->open
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 60
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 64
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 149
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 153
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 157
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 161
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 165
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 1
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:21:59 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 2
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_name Name: unassociated
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_freq GET Freq/Channel -> 0 
Nov 12 18:21:59 localhost kernel: ieee80211: U ieee80211_wx_get_encode GET_ENCODE
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_essid Getting essid: ANY
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_mode Get MODE -> 2
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_range GET Range
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_wap Getting WAP BSSID: 00:00:00:00:00:00
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_nick Getting nick
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_rate GET Rate -> 0 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_rts GET RTS Threshold -> 2304 
Nov 12 18:21:59 localhost kernel: ipw2200: U ipw_wx_get_frag GET Frag Threshold -> 2346 
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_power GET Power Management Mode -> 06
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_txpow GET TX Power -> ON 20 
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_retry GET retry -> 7 
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 3
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_name Name: unassociated
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_freq GET Freq/Channel -> 0 
Nov 12 18:22:00 localhost kernel: ieee80211: U ieee80211_wx_get_encode GET_ENCODE
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_essid Getting essid: ANY
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_mode Get MODE -> 2
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_range GET Range
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_wap Getting WAP BSSID: 00:00:00:00:00:00
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_nick Getting nick
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_rate GET Rate -> 0 
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_rts GET RTS Threshold -> 2304 
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_frag GET Frag Threshold -> 2346 
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_power GET Power Management Mode -> 06
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_txpow GET TX Power -> ON 20 
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_wx_get_retry GET retry -> 7 
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 4
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 5
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 6
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_rx_mgt received BEACON (128)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_rx_mgt Beacon
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_process_probe_response 'RTR' (00:13:46:16:96:b8): 0000 0100-0011 0001
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_SSID: 'RTR' len=3.
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_RATES: '82 84 8B 96 8C 98 B0 48 ' (8)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_DS_SET: 8
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_TIM: ignored
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_ERP_SET: 0
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_RATES_EX: '82 84 8B 96 ' (4)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_GENERIC: 22 bytes
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_process_probe_response Adding 'RTR' (00:13:46:16:96:b8) via BEACON.
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 25 (4 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 7
Nov 12 18:22:00 localhost dhclient: Listening on LPF/eth1/00:12:f0:4a:63:6e
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_rx_mgt received PROBE RESPONSE (80)
Nov 12 18:22:00 localhost dhclient: Sending on   LPF/eth1/00:12:f0:4a:63:6e
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_rx_mgt Probe response
Nov 12 18:22:00 localhost dhclient: Sending on   Socket/fallback
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_process_probe_response 'RTR' (00:13:46:16:96:b8): 0000 0100-0011 0001
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_SSID: 'RTR' len=3.
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_RATES: '82 84 8B 96 8C 98 B0 48 ' (8)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_DS_SET: 8
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_ERP_SET: 0
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_RATES_EX: '82 84 8B 96 ' (4)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_GENERIC: 22 bytes
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_process_probe_response Updating 'RTR' (00:13:46:16:96:b8) via PROBE RESPONSE.
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 25 (4 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 8
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 9
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 10
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_rx_mgt received BEACON (128)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_rx_mgt Beacon
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_process_probe_response 'RTR' (00:13:46:16:96:b8): 0000 0100-0011 0001
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_SSID: 'RTR' len=3.
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_RATES: '82 84 8B 96 8C 98 B0 48 ' (8)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_DS_SET: 8
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_TIM: ignored
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_ERP_SET: 0
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_RATES_EX: '82 84 8B 96 ' (4)
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_parse_info_param MFIE_TYPE_GENERIC: 22 bytes
Nov 12 18:22:00 localhost kernel: ieee80211: I ieee80211_process_probe_response Updating 'RTR' (00:13:46:16:96:b8) via BEACON.
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 25 (4 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 12 (46 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan result for channel 11
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification type = 13 (4 bytes)
Nov 12 18:22:00 localhost kernel: ipw2200: I ipw_rx_notification Scan completed: type 11, 24 channels, 1 status
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_best_network Network 'RTR (00:13:46:16:96:b8)' excluded because of privacy mismatch: off != on.
Nov 12 18:22:00 localhost kernel: ipw2200: U ipw_debug_config Scan completed, no valid APs matched [CFG 0x00000340]

--------------090506090102070201090900--
