Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTLLAMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTLLAMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:12:24 -0500
Received: from pop.gmx.de ([213.165.64.20]:45697 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264422AbTLLAMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:12:21 -0500
X-Authenticated: #5734216
From: rene.rebe@gmx.net
To: linux-kernel@vger.kernel.org
Subject: ieee1394 / sbp2 problem accessing iBook in target disk mode
Date: Fri, 12 Dec 2003 01:12:02 +0100
User-Agent: KMail/1.5.4
Cc: jamesg@filanet.com, inux1394-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312120112.02778.rene.rebe@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to access another iBook in target disk mode via the sbp2 driver 
running a 2.4.22-benh2 kernel. The device (the other iBook) is detected but 
can not ba accessed properly:

ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max 
Packet=[2048]
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[000a95fffeea7b48]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000a95fffea13034]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc10120 ffc07000 00000000 9ce61184
sbp2: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
blk: queue e5fb0014, I/O limit 4095Mb (mask 0xffffffff)
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
scsi singledevice 3 0 0 0
scsi singledevice 1 0 0 0
  Vendor: AAPL      Model: FireWire Target   Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue e5e0e214, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
ieee1394: sbp2: aborting sbp2 command
0x00 00 00 00 00 00 
sda: Unit Not Ready, sense:
Current 00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x3a 0x00 0x00 0x00 0x00 0x00 
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sns = 70  2
ASC=3a ASCQ= 0
Raw sense data:0x70 0x00 0x02 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 
0x3a 0x00 0x00 0x00 0x00 0x00 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host1/bus0/target0/lun0: I/O error: dev 08:00, sector 0
 I/O error: dev 08:00, sector 0
 unable to read partition table

Of course it works under MacOS-X and also networking via the eth1394 driver is 
working nicely between the two Linux iBooks.

Is this problem know or any ideas?

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de
http://gsmp.rocklinux-consulting.de/ http://gsmp.tfh-berlin.de/rene


