Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275102AbTHGELR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 00:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275100AbTHGELR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 00:11:17 -0400
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:57317 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S275098AbTHGELM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 00:11:12 -0400
Message-ID: <3F31D205.2080008@vgertech.com>
Date: Thu, 07 Aug 2003 05:13:57 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Michael Buesch <fsdeveloper@yahoo.de>
CC: insecure@mail.od.ua,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [2.6] system is very slow during disk access
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062331.08020.insecure@mail.od.ua> <200308062247.17816.fsdeveloper@yahoo.de>
In-Reply-To: <200308062247.17816.fsdeveloper@yahoo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There are some references to: hdparm -a 512 /dev/hda.
For some folks this improves fs performance.

Does it work for you?

Regards,
Nuno Silva

Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Wednesday 06 August 2003 22:31, insecure wrote:
> 
>>hdparm -T -t output? dmesg? lspci? /proc/ide stuff?
> 
> 
> 
> root@lfs:/home/mb> hdparm -T -t /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.37 seconds =343.22 MB/sec
>  Timing buffered disk reads:  64 MB in  1.53 seconds = 41.81 MB/sec
> 
> 
> dmesg doesn't show any unusual messages.
> 
> 
> root@lfs:/home/mb> lspci 
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
> 01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4400] (rev a2)
> 03:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> 03:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> 03:03.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
> 03:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
> 03:0c.0 USB Controller: NEC Corporation USB (rev 41)
> 03:0c.1 USB Controller: NEC Corporation USB (rev 41)
> 03:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
> 
> root@lfs:/home/mb> cat /proc/ide/drivers 
> ide-cdrom version 4.59-ac1
> ide-disk version 1.18
> 
> root@lfs:/home/mb> cat /proc/ide/hda/settings 
> name                    value           min             max             mode
> - ----                    -----           ---             ---             ----
> acoustic                0               0               254             rw
> address                 0               0               2               rw
> bios_cyl                79780           0               65535           rw
> bios_head               16              0               255             rw
> bios_sect               63              0               63              rw
> bswap                   0               0               1               r
> current_speed           69              0               70              rw
> failures                0               0               65535           rw
> init_speed              69              0               70              rw
> io_32bit                1               0               3               rw
> keepsettings            0               0               1               rw
> lun                     0               0               7               rw
> max_failures            1               0               65535           rw
> multcount               16              0               16              rw
> nice1                   1               0               1               rw
> nowerr                  0               0               1               rw
> number                  0               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> unmaskirq               0               0               1               rw
> using_dma               1               0               1               rw
> wcache                  0               0               1               rw
> 
> 
> root@lfs:/home/mb> cat /proc/ide/hda/model 
> IC35L040AVVA07-0
> 
> 
> 
>>--
>>insecure
> 
> 
> - -- 
> Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
> Penguin on this machine:  Linux 2.6.0-test2 - i386
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> 
> iD8DBQE/MWlSoxoigfggmSgRAjXOAJ9zyjWGS7G30ScpX+qff+xCY0AEzACfRVvQ
> 42uPwSsmoPv5hte149jD398=
> =XNT2
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

