Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287163AbSALQhv>; Sat, 12 Jan 2002 11:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSALQhl>; Sat, 12 Jan 2002 11:37:41 -0500
Received: from mx.fluke.com ([129.196.128.53]:57360 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S287163AbSALQh1>; Sat, 12 Jan 2002 11:37:27 -0500
Date: Sat, 12 Jan 2002 08:37:37 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.2-pre11 / IDE cdrom_read_intr: data underrun / end_request: I/O
 error
In-Reply-To: <Pine.LNX.4.33.0201111841320.193-100000@dd.tc.fluke.com>
Message-ID: <Pine.LNX.4.33.0201120834140.672-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002 at 18:55 -0800, David Dyck <dcd@tc.fluke.com> wrote:

I had been testing 2.5.2-pre11 and earlier, but hadn't looked at
reading from my cdrom for a while.  Yesterday I created examined several
large cdrom sets that had been readable earlier and they read partially
but get read errors.  These same cdroms can be read reliable on
2.4.18-pre3 using the same hardware, and are readable on other
PC's runing older kernels.

Has anyone else seen cdrom read errors with 2.5.2-pre* kernels?

Using 2.5.2-pre11

# mount /cdrom && md5sum /cdrom/*
md5sum: /cdrom/dcd-c.tar.gz: I/O error
md5sum: /cdrom/dcd-d.tar.gz: I/O error


An example of some of the messages were

    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: NEC CD-ROM DRIVE:28B, ATAPI CD/DVD-ROM drive
hdc: ATAPI 32X CD-ROM drive, 256kB Cache


VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
hdc: cdrom_read_intr: data underrun (4294967256 blocks)
end_request: I/O error, dev 16:00, sector 299300
hdc: cdrom_read_intr: data underrun (4294967260 blocks)
end_request: I/O error, dev 16:00, sector 299304

  errors repeated with sector and blocks increasing by 4
  repeating 118 times


using 2.4.18-pre3 I get no errors

