Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270617AbTGZV0j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270618AbTGZV0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:26:38 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:33499 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S270426AbTGZVY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:24:57 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: ieee1394/sbp2 plug doesn't work
Date: Sat, 26 Jul 2003 23:40:04 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307262340.04910.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just trying to  make my firewire CDROM work in 2.6. 
I found that it only works if the device is attached when
the machine is booted. 

If you plug it after booting it gives all the following errors. 
It doesn't stop until you unplug the device again.

------------------------------
ul 26 23:31:10 minime kernel: ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[00065b80040f4934]
Jul 26 23:31:11 minime kernel: ieee1394: sbp2: Logged out of SBP-2 device
Jul 26 23:32:10 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:10 minime kernel: ieee1394: contents: ffc0c160 ffc00000 00000000 14f10404
Jul 26 23:32:11 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:11 minime kernel: ieee1394: contents: ffc0c560 ffc00000 00000000 14f10404
Jul 26 23:32:11 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:11 minime kernel: ieee1394: contents: ffc0c960 ffc00000 00000000 14f10404
Jul 26 23:32:12 minime kernel: ieee1394: ConfigROM quadlet transaction error for node 00:1023
Jul 26 23:32:13 minime kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul 26 23:32:13 minime kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Jul 26 23:32:13 minime kernel: ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00065b80040f4934]
Jul 26 23:32:13 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:13 minime kernel: ieee1394: contents: ffc16560 ffc10000 00000000 14f10404
Jul 26 23:32:13 minime kernel: scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
Jul 26 23:32:13 minime kernel: ieee1394: sbp2: Logged into SBP-2 device
Jul 26 23:32:13 minime kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul 26 23:32:13 minime kernel:   Vendor: SAMSUNG   Model: CD-ROM SN-124     Rev: N102
Jul 26 23:32:13 minime kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jul 26 23:32:14 minime kernel: sr0: scsi3-mmc drive: 0x/0x caddy
Jul 26 23:32:14 minime kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Jul 26 23:32:14 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:14 minime kernel: ieee1394: contents: ffc16960 ffc10000 00000000 14f10404
Jul 26 23:32:14 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:14 minime kernel: ieee1394: contents: ffc16d60 ffc10000 00000000 14f10404
Jul 26 23:32:15 minime kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul 26 23:32:15 minime kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Jul 26 23:32:15 minime kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul 26 23:32:15 minime kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul 26 23:32:15 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:15 minime kernel: ieee1394: contents: ffc17160 ffc10000 00000000 14f10404
Jul 26 23:32:16 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:16 minime kernel: ieee1394: contents: ffc17560 ffc10000 00000000 14f10404
Jul 26 23:32:16 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:16 minime kernel: ieee1394: contents: ffc17960 ffc10000 00000000 14f10404
Jul 26 23:32:16 minime kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul 26 23:32:16 minime kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Jul 26 23:32:17 minime kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul 26 23:32:17 minime kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul 26 23:32:17 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:17 minime kernel: ieee1394: contents: ffc17d60 ffc10000 00000000 14f10404
Jul 26 23:32:17 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:17 minime kernel: ieee1394: contents: ffc18160 ffc10000 00000000 14f10404
Jul 26 23:32:18 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:18 minime kernel: ieee1394: contents: ffc18560 ffc10000 00000000 14f10404
Jul 26 23:32:18 minime kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul 26 23:32:18 minime kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Jul 26 23:32:18 minime kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul 26 23:32:19 minime kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
Jul 26 23:32:19 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:19 minime kernel: ieee1394: contents: ffc18960 ffc10000 00000000 14f10404
Jul 26 23:32:19 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:19 minime kernel: ieee1394: contents: ffc18d60 ffc10000 00000000 14f10404
Jul 26 23:32:19 minime kernel: ieee1394: unsolicited response packet received - np
Jul 26 23:32:19 minime kernel: ieee1394: contents: ffc19160 ffc10000 00000000 14f10404
Jul 26 23:32:20 minime kernel: ieee1394: ConfigROM quadlet transaction error for node 01:1023
Jul 26 23:32:20 minime kernel: ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Jul 26 23:32:20 minime kernel: ieee1394: sbp2: Reconnected to SBP-2 device
Jul 26 23:32:20 minime kernel: ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
....



-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

