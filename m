Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUFILxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUFILxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUFILxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 07:53:34 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:1371 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S265743AbUFILx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 07:53:27 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: aacraid does not work on dual opteron box - 2.6.7-rc2
Date: Wed, 9 Jun 2004 12:50:25 +0100
User-Agent: KMail/1.6.1
Cc: Sergiusz Pawlowicz <ser@gnu.org>, linux-scsi@vger.kernel.org
References: <20040609083142.GB23062@szafa>
In-Reply-To: <20040609083142.GB23062@szafa>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406091250.25860.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hello linux friends,
> sorry for bothering you, but  current aacraid still does not
> work properly on  my fresh dual opteron box  & Adaptec 2120S
> RAID controler. It hungs  always after modprobing sd_mod and
> disk access try.
>

<snip>

Not sure if this helps but I'm running a Dual Opteron 248 with 2 (two) Adaptec 
AAR-2410SA cards in PCI-X slots on a Tyan S2885 board.


# uname -a
Linux localhost 2.6.3-7mdk-p3-smp-64GB #1 SMP Wed Mar 17 15:34:39 CET 2004 
i686 unknown unknown GNU/Linux

Red Hat/Adaptec aacraid driver (1.1.2-lk1 Mar 17 2004)
AAC0: kernel 4.1.4 build 5934
AAC0: monitor 4.1.4 build 5934
AAC0: bios 4.1.0 build 5934
AAC0: serial ba7127fafaf001
scsi0 : aacraid
  Vendor: ADAPTEC   Model: AAR-2410SA RAID5  Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
AAC1: kernel 4.1.4 build 5934
AAC1: monitor 4.1.4 build 5934
AAC1: bios 4.1.0 build 5934
AAC1: serial bab51afafaf001
scsi1 : aacraid
  Vendor: ADAPTEC   Model: AAR-2410SA Mirro  Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 216790272 512-byte hdwr sectors (110997 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72263424 512-byte hdwr sectors (36999 MB)
sdb: Write Protect is off
sdb: Mode Sense: 03 00 00 00
SCSI device sdb: drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 < p5 p6 >
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0

AAC0 is a 4x36GB raid5 array with WD Raptor SATA drives
AAC1 is a 2x36GB raid1 mirror with the same drives

- From lsmod:

sd_mod                 18592  6
aacraid                45248  4
scsi_mod              121552  2 sd_mod,aacraid

# uptime
 13:55:38 up 22 days, 21:47,  1 user,  load average: 0.00, 0.00, 0.00

This is a Mandrake 10.0 Official system.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxvmBBn4EFUVUIO0RAobNAJ9VrbE2/gBxonNEw0kOyAGgXaU0+gCgimxx
gci7EWybhvIRmaStjcS5FLI=
=LyFx
-----END PGP SIGNATURE-----
