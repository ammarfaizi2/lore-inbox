Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281545AbRKMG5v>; Tue, 13 Nov 2001 01:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281549AbRKMG5m>; Tue, 13 Nov 2001 01:57:42 -0500
Received: from codepoet.org ([166.70.14.212]:11561 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S281545AbRKMG50>;
	Tue, 13 Nov 2001 01:57:26 -0500
Date: Mon, 12 Nov 2001 23:57:27 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Partitioning wierdness with 2048-byte sectors
Message-ID: <20011112235727.A6932@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just trying out 2.4.15-pre4 and noticed that I am
completely unable to create partitions on my magneto optical
drives (2048 byte hardware sectors).  Using fdisk to (try to)
create a single partition uttery fails.  dmesg shows:

    ll_rw_block: device 08:10: only 2048-char blocks implemented (1024)
    sd.c:Bad block number requested I/O error: dev 08:10, sector 0
    SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
    sdb: Write Protect is off
     sdb: unknown partition table
    SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
    sdb: Write Protect is off
     sdb: unknown partition table

With 2.4.13-ac5 doing the exact same thing works fine with the
following showing up when running dmesg:

    ll_rw_block: device 08:10: only 2048-char blocks implemented (1024)
    SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
    sdb: Write Protect is off
     sdb: sdb1
    SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
    sdb: Write Protect is off
     sdb: sdb1

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
