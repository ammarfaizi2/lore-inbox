Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135855AbRDYMoX>; Wed, 25 Apr 2001 08:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135860AbRDYMoD>; Wed, 25 Apr 2001 08:44:03 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:12298 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S135855AbRDYMoB>; Wed, 25 Apr 2001 08:44:01 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDB0@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [POT] eepro100 crash my 2.4.2smp on Alpha ES40 under network load
	!
Date: Wed, 25 Apr 2001 14:42:30 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My hardware configuration is:

	AlphaServer ES40, 4 cpus, 8 Gigas of RAM

	lspci -tv shows the network board as:

	Intel Corporation 82557 [ Ethernet Pro 100 ]

The driver is inserted as a module: lsmod shows eepro100 loaded.


The system is Redhat 7.0 with updates and 2.4.2 kernel hand compiled
with egcs-2.91.66.

As long as I do not stress too much the network everything is fine. I can
transfer
little files but when I do big transfers: I see on the /var/log/messages:

	NETDEV WATCHDOG | eth0: transmit timeout
				 status 0090 0c00 at xxxxxx/xxxxxx command
000ca000
				 wait_cmd_done timeout.


I if instist and launch another transfer, the system freeze, I loose the
console and the 
network and I must do a hard reboot.

PS:With 2.2 the problem was fixed by changing the eepro100 driver with the
package
of donald becker on www.scyld.com, but I can't load it in my 2.4 kernel. 

Any help would be much appreciated.



Sebastien CABANIOLS

  
