Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130858AbRBSSbk>; Mon, 19 Feb 2001 13:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130828AbRBSSba>; Mon, 19 Feb 2001 13:31:30 -0500
Received: from pompeiu.imar.ro ([193.226.4.7]:58244 "HELO pompeiu.imar.ro")
	by vger.kernel.org with SMTP id <S130858AbRBSSbW>;
	Mon, 19 Feb 2001 13:31:22 -0500
Date: Mon, 19 Feb 2001 20:32:07 +0200
From: Ionut Dumitrache <Ionut.Dumitrache@imar.ro>
To: linux-kernel@vger.kernel.org
Subject: i82562ET LAN (i815) timeout/lockup with eepro100 driver
Message-ID: <20010219203207.1500015381@pompeiu.imar.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii

        The integrated LAN on Intel boards with i815 chipset 
apparently is not fully supported. In latest 2.2.x and 2.4.x,
with the EtherExpress Pro100 driver, after some network traffic,
it locks. The only way I can use the net again is either reboot,
or ifconfig eth0 down; ifconfig eth0 up. 
   I attached the syslog output;

The driver detects the chip as 82562EM although the mainboard
manual states that it has an integrated i82562ET chip.

Board: Intel D815EEA with onboard LAN, video,audio

----
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
eth0: Intel PCI EtherExpress Pro100 82562EM, 00:03:47:48:7E:41, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
---

        Any idea why this happens?

P.S Please cc-me, I'm not subscribed to the list.

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=errors-intel

Feb 17 17:35:51 banica kernel: eepro100: wait_for_cmd_done timeout!
Feb 17 17:36:00 banica last message repeated 2 times
Feb 17 17:37:04 banica last message repeated 9 times
Feb 17 17:37:23 banica kernel: memory : c7a70720
Feb 17 17:37:23 banica kernel: memory : 00000000
Feb 17 17:37:23 banica kernel: memory : c7a70760
Feb 17 17:39:27 banica kernel: eepro100: wait_for_cmd_done timeout!
Feb 17 17:39:37 banica last message repeated 7 times
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out: status 0050  0cf0 at 119493/119521 command 000c0000.
eth0: Tx ring dump,  Tx queue 119521 / 119493:
eth0:     0 600c0000.
eth0:   = 1 000ca000.
eth0:     2 000ca000.
eth0:     3 000ca000.
eth0:     4 000ca000.
eth0:  *  5 000c0000.
eth0:     6 000c0000.
eth0:     7 000c0000.
eth0:     8 200c0000.
eth0:     9 000c0000.
eth0:    10 000c0000.
eth0:    11 000c0000.
eth0:    12 000c0000.
eth0:    13 000c0000.
eth0:    14 000c0000.
eth0:    15 000c0000.
eth0:    16 200c0000.
eth0:    17 000c0000.
eth0:    18 000c0000.
eth0:    19 000c0000.
eth0:    20 000c0000.
eth0:    21 000c0000.
eth0:    22 000c0000.
eth0:    23 000c0000.
eth0:    24 200c0000.
eth0:    25 000c0000.
eth0:    26 000c0000.
eth0:    27 000c0000.
eth0:    28 000c0000.
eth0:    29 000c0000.
eth0:    30 000c0000.
eth0:    31 000c0000.
eth0: Printing Rx ring (next to receive into 161286, dirty index 161286).
eth0:     0 00000001.
eth0:     1 00000001.
eth0:     2 00000001.
eth0:     3 00000001.
eth0:     4 00000001.
eth0: l   5 c0000001.
eth0:  *= 6 00000001.
eth0:     7 00000001.
eth0:     8 00000001.
eth0:     9 00000001.
eth0:    10 00000001.
eth0:    11 00000001.
eth0:    12 00000001.
eth0:    13 00000001.
eth0:    14 00000001.
eth0:    15 00000001.
eth0:    16 00000001.
eth0:    17 00000001.
eth0:    18 00000001.
eth0:    19 00000001.
eth0:    20 00000001.
eth0:    21 00000001.
eth0:    22 00000001.
eth0:    23 00000001.
eth0:    24 00000001.
eth0:    25 00000001.
eth0:    26 00000001.
eth0:    27 00000001.
eth0:    28 00000001.
eth0:    29 00000001.
eth0:    30 00000001.
eth0:    31 00000001.
eepro100: wait_for_cmd_done timeout!
-------------
Feb 17 17:49:39 banica kernel: eepro100: cmd_wait for(0xffffff80) timedout with(0xffffff80)!
Feb 17 17:50:12 banica last message repeated 29 times
Feb 17 17:50:53 banica last message repeated 8 times
Feb 17 17:52:26 banica last message repeated 4 times
Feb 17 17:52:37 banica kernel: eepro100: cmd_wait for(0xfffffff0) timedout with(0xfffffff0)!

--J/dobhs11T7y2rNN--
