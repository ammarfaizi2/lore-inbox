Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265635AbSJXUbI>; Thu, 24 Oct 2002 16:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSJXUbI>; Thu, 24 Oct 2002 16:31:08 -0400
Received: from packet.digeo.com ([12.110.80.53]:16786 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265635AbSJXUbH> convert rfc822-to-8bit;
	Thu, 24 Oct 2002 16:31:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: IDE IO error question ...
Date: Thu, 24 Oct 2002 13:37:15 -0700
Message-ID: <4C568C6A13479744AA1EA3E97EEEB32328EEA4@schumi.digeo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE IO error question ...
Thread-Index: AcJ7nSNAhl3qUVOZSMKIVdbvAvIJ9g==
From: "Michael Duane" <Mike.Duane@digeo.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few identical systems exhibiting the same problems where
I already know that the ATA-100 cable is installed backwards.  What
I am trying to find out is whether the errors I am seeing are related
or if I have two problems.

1:  With the IDE cable reversed hdparm shows the max and effective
    udma2 which slows the system (of course).

2:  IO Errors using reiserfs on a brand new hard drive:

    A:  create a partition and mkfs -treiserfs with no reported errors
    B:  mounting the new fs reports the following:
          kernel: ReiserFS version 3.6.25
          loadbase: mount: wrong fs type, bad option, bad superblock 
             on /dev/hda5,
          loadbase:        or too many mounted file systems
          kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
          kernel: hda: dma_intr: error=0x40 { UncorrectableError }, 
             LBAsect=106988451, sector=105381888
          kernel: end_request: I/O error, dev 03:05 (hda), sector 105381888
          kernel: reiserfs_read_super: unable to read bitmap
    C:  Removing the drive and installing it on a correctly built system
        and scanning it for bad sectors reports uncorrectable ECC errors
        at the same LBA.

So, is it possible that I am physically damaging the drive when the IDE
cable is installed with the wrong end at the host?

Mike


