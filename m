Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUH2QGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUH2QGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUH2QGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:06:47 -0400
Received: from lucidpixels.com ([66.45.37.187]:45235 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S268056AbUH2QGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:06:16 -0400
Date: Sun, 29 Aug 2004 12:06:10 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.8.1 DMA+DVD read errors!
Message-ID: <Pine.LNX.4.61.0408291123590.24663@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A freshly burned DVD at 1x cannot be read with DMA on or off.

Model: hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive

$ dd if=/dev/hdd of=dvd.iso
dd: reading `/dev/hdd': Input/output error
6781136+0 records in
6781136+0 records out

# hdparm -d0 /dev/hdd

/dev/hdd:
  setting using_dma to 0 (off)
  using_dma    =  0 (off)

then:

$ dd if=/dev/hdd of=dvd.iso
dd: reading `/dev/hdd': Input/output error
7080400+0 records in
7080400+0 records out

Buffer I/O error on device hdd, logical block 885060
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error 
}
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 7080488
Buffer I/O error on device hdd, logical block 885061
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error 
}
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 7080400
Buffer I/O error on device hdd, logical block 885050


Any idea when this will be fixed?
