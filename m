Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422950AbWCUSic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422950AbWCUSic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423225AbWCUSiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:38:24 -0500
Received: from mail.linicks.net ([217.204.244.146]:960 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1423241AbWCUShk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:37:40 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Modprobe sd_mod question?
Date: Tue, 21 Mar 2006 18:37:28 +0000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603211837.28490.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am getting this FATAL when I plug in my usb memory stick  - everything all 
works though:


Mar 21 18:02:51 linuxamd kernel: usb 2-1.2: new full speed USB device using 
uhci_hcd and address 6
Mar 21 18:02:52 linuxamd kernel: scsi1 : SCSI emulation for USB Mass Storage 
devices
Mar 21 18:02:57 linuxamd kernel:   Vendor:           Model: USB DRIVE         
Rev: 1.13
Mar 21 18:02:57 linuxamd kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 00
Mar 21 18:02:57 linuxamd kernel: SCSI device sda: 62464 512-byte hdwr sectors 
(32 MB)
Mar 21 18:02:57 linuxamd kernel: sda: Write Protect is off
Mar 21 18:02:57 linuxamd kernel: SCSI device sda: 62464 512-byte hdwr sectors 
(32 MB)
Mar 21 18:02:57 linuxamd kernel: sda: Write Protect is off
Mar 21 18:02:57 linuxamd kernel:  sda: sda1
Mar 21 18:02:57 linuxamd kernel: sd 1:0:0:0: Attached scsi removable disk sda
Mar 21 18:02:57 linuxamd kernel: sd 1:0:0:0: Attached scsi generic sg0 type 0
Mar 21 18:02:57 linuxamd modprobe: FATAL: Module sd_mod not found.
Mar 21 18:03:47 linuxamd kernel: usb 2-1.2: USB disconnect, address 6



I only have two modules - nVidia and Vicam.  Everything else is built in.



Corresponding .config

# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set



My /etc/modprobe.conf and /etc/modules are empty.



kernel 2.6.15.6
module-init-tools version 3.0


Ideas what/why (it) is doing this probe for non-existant module?

Thanks,

Nick

-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
