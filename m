Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbVKPXS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVKPXS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbVKPXS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:18:26 -0500
Received: from iotaanl.aps.anl.gov ([164.54.56.3]:64310 "EHLO zeta.aps.anl.gov")
	by vger.kernel.org with ESMTP id S1030559AbVKPXSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:18:25 -0500
Message-ID: <437BBE38.4030103@aps.anl.gov>
Date: Wed, 16 Nov 2005 17:18:16 -0600
From: Shifu Xu <xusf@aps.anl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Red Hat/1.7.10-1.1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Net boot problem of patch-2.6.14-rt12  on Powerpc board
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I tried to boot linux 2.6.14 with patch-2.6.14-rt12 applied 
on mvme2100 board, dhcp just didn't work:

Linux version 2.6.14-rt12 () (gcc version 3.4.2) #7 PREEMPT Tue Nov 15 16:01:11 CST 2005
Platform: Motorola MVME2100
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: console=ttyS0,9600 ip=dhcp
WARNING: experimental RCU implementation.
PID hash table entries: 256 (order: 8, 4096 bytes)
time_init: decrementer frequency = 16.666767 MHz
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30444k available (1448k kernel code, 440k data, 116k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
                                                                                                                  
PCI: Probing PCI hardware
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 29) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at febfef80, 00:01:AF:09:0D:EA, IRQ 17.
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 5, 139264 bytes)
TCP bind hash table entries: 2048 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Sending DHCP requests .<6>eth0: Setting half-duplex based on MII#8 link partner capability of 0021.
..... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests .<6>eth0: Setting half-duplex based on MII#8 link partner capability of 0021.
..... timed out!


When the patch is not applied, it works.

Shifu



