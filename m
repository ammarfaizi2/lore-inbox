Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274960AbTHFUr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274966AbTHFUr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:47:28 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:9487 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S274960AbTHFUrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:47:23 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: insecure@mail.od.ua
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 22:47:14 +0200
User-Agent: KMail/1.5.3
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062331.08020.insecure@mail.od.ua>
In-Reply-To: <200308062331.08020.insecure@mail.od.ua>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308062247.17816.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 22:31, insecure wrote:
> hdparm -T -t output? dmesg? lspci? /proc/ide stuff?


root@lfs:/home/mb> hdparm -T -t /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.37 seconds =343.22 MB/sec
 Timing buffered disk reads:  64 MB in  1.53 seconds = 41.81 MB/sec


dmesg doesn't show any unusual messages.


root@lfs:/home/mb> lspci 
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4400] (rev a2)
03:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
03:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
03:03.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
03:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
03:0c.0 USB Controller: NEC Corporation USB (rev 41)
03:0c.1 USB Controller: NEC Corporation USB (rev 41)
03:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

root@lfs:/home/mb> cat /proc/ide/drivers 
ide-cdrom version 4.59-ac1
ide-disk version 1.18

root@lfs:/home/mb> cat /proc/ide/hda/settings 
name                    value           min             max             mode
- ----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                79780           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           69              0               70              rw
failures                0               0               65535           rw
init_speed              69              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw


root@lfs:/home/mb> cat /proc/ide/hda/model 
IC35L040AVVA07-0


> --
> insecure

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MWlSoxoigfggmSgRAjXOAJ9zyjWGS7G30ScpX+qff+xCY0AEzACfRVvQ
42uPwSsmoPv5hte149jD398=
=XNT2
-----END PGP SIGNATURE-----

