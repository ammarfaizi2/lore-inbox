Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273999AbRISEU0>; Wed, 19 Sep 2001 00:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274001AbRISEUQ>; Wed, 19 Sep 2001 00:20:16 -0400
Received: from pool-151-196-235-135.balt.east.verizon.net ([151.196.235.135]:29201
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S273999AbRISEUI>; Wed, 19 Sep 2001 00:20:08 -0400
Date: Wed, 19 Sep 2001 00:21:38 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Ben Greear <greearb@candelatech.com>
cc: eepro list <eepro100@scyld.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [eepro100] eepro100 driver (2.4 kernel) fails with S2080 Tomcat
 i815t motherboard.
In-Reply-To: <3BA800DD.8C72F065@candelatech.com>
Message-ID: <Pine.LNX.4.10.10109190016140.19173-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Ben Greear wrote:

> I have a Tyan motherboard (S2080 Tomcat i815t) with 2 built-in NICs.
> 
> The manual claims this:
> 
> "One Intel 82559 LAN controller
>  One ICH2 LAN controller"
> 
> Seems that the eepro driver tries to bring up both of
> them, and fails to read the eeprom on the second one it
> scans.  One visible result is that the MAC is all FF's.

Does the diagnostic program correctly read the EEPROM on both cards?
If so, my driver release should work with the cards.

> eth0: Intel Corporation 82557 [Ethernet Pro 100] (#3), 00:E0:81:03:B9:7B, IRQ 10.
> eth1: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:90:27:65:39:1B, IRQ 3.
> eth2: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:65:37:8A, IRQ 9.
> eth3: Invalid EEPROM checksum 0xff00, check settings before activating this device!
> eth3: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 11.

> [root@lanf2 /root]# eepro100-diag -aaeemmf eth3

The diagnostic does not (and cannot) know which card is "eth3".
(Consider the case where no driver is loaded.)

You must specify the interface to examine with e.g. "-#3" 

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

