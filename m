Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965816AbWKEDa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965816AbWKEDa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965817AbWKEDa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:30:27 -0500
Received: from web38401.mail.mud.yahoo.com ([209.191.125.32]:56434 "HELO
	web38401.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965816AbWKEDa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:30:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CuWCvsGn1wKyM/xdx6nTHXaMsCKKlG7LcJ/mA4OOcB+ZUMy33/cEm1XXzO+xwSl4NzaSPN9SoVqQN2TU4RSLohUf9Qf5W4uBfmqiK67hNeNljm4qxSd0El4yCT0YFPLeeXaS9XWTVTG4FgeH4Ybo7dGYMgw6Me8j/ukV1MS2G/Q=  ;
Message-ID: <20061105033026.53019.qmail@web38401.mail.mud.yahoo.com>
Date: Sat, 4 Nov 2006 19:30:26 -0800 (PST)
From: xp newbie <xp_newbie@yahoo.com>
Subject: How do I know whether a specific driver being used?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using an Ubuntu system with kernel 2.6.15-27-686.

I am trying to find out whether I need to compile
myself a driver for my Promise FastTrack 378
controller as described here:

http://www.linuxquestions.org/questions/showthread.php?t=362780

But before doing so, I prefer to know in advance (if
possible) whether this module is already included in
(and perhaps used by) the kernel.

The instructions in the README file for building this
particular driver say:

------- START QUOTE -------
7.) Copy this module to
/lib/modules/2.4.x/kernel/drivers/scsi/

    

8.) Issue "cat /proc/scsi/ft3xx/x" (x is a SCSI host
number) to get the
 RAID array status.

------- END QUOTE -------

Due to different kernel I am using, the path is of
course different, so I listed the modules in:

/lib/modules/2.6.15-27-686/kernel/drivers/scsi/ 

and found no ft3xx entry.

However, I did find a promising entry (no pun
intended):

-rw-r--r-- 1 root root  16219 2006-09-15 23:49
sata_promise.ko

I then did "ls -l /proc/scsi/sata_promise" and
received:
-rw-r--r-- 1 root root 0 2006-11-04 22:23 0
-rw-r--r-- 1 root root 0 2006-11-04 22:23 1
-rw-r--r-- 1 root root 0 2006-11-04 22:23 2

a 'cat' on any of these "files" yields the message:

"The driver does not yet support the proc-fs"

Please note that I am using this Promise controller to
connect to a single PATA drive, not SATA.

The relevant part in my dmesg reads:

[17179575.120000] sata_promise PATA port found
[17179575.136000] ata1: SATA max UDMA/133 cmd
0xF8866200 ctl 0xF8866238 bmdma 0x0 irq 169
[17179575.140000] ata2: SATA max UDMA/133 cmd
0xF8866280 ctl 0xF88662B8 bmdma 0x0 irq 169
[17179575.140000] ata3: PATA max UDMA/133 cmd
0xF8866300 ctl 0xF8866338 bmdma 0x0 irq 169
[17179575.344000] ata1: no device found (phy stat
00000000)
[17179575.344000] scsi0 : sata_promise
[17179575.552000] ata2: no device found (phy stat
00000000)
[17179575.552000] scsi1 : sata_promise
[17179575.728000] ata3: dev 0 cfg 00:045a 49:2f00
82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003
88:407f 93:600b
[17179575.728000] ata3: dev 0 ATA-7, max UDMA/133,
312581808 sectors: LBA48
[17179575.728000] ata3: dev 0 configured for UDMA/133
[17179575.728000] sata_get_dev_handle: SATA dev
addr=0x40000, handle=0x00000000
[17179575.728000] scsi2 : sata_promise
[17179575.728000]   Vendor: ATA       Model: SAMSUNG
SP1614N   Rev: TM10
[17179575.728000]   Type:   Direct-Access             
        ANSI SCSI revision: 05
[17179575.732000] Driver 'sd' needs updating - please
use bus_type methods
[17179575.732000] SCSI device sda: 312581808 512-byte
hdwr sectors (160042 MB)
[17179575.732000] SCSI device sda: drive cache: write
back
[17179575.732000] SCSI device sda: 312581808 512-byte
hdwr sectors (160042 MB)
[17179575.732000] SCSI device sda: drive cache: write
back
[17179575.732000]  sda: sda2 sda3 sda4 < sda5 sda6 >
[17179575.780000] sd 2:0:0:0: Attached scsi disk sda


How do I decipher all this information so that I can
tell whether I am using the correct driver for this
particular part of my hardware or not?

Is it possible that "the right driver" is already
there and I don't have to compile anything? :)

Thanks!
Alex










 
____________________________________________________________________________________
Get your email and see which of your friends are online - Right on the New Yahoo.com 
(http://www.yahoo.com/preview) 

