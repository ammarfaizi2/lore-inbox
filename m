Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280314AbRKEHxX>; Mon, 5 Nov 2001 02:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280321AbRKEHxN>; Mon, 5 Nov 2001 02:53:13 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:11205 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S280317AbRKEHxC>;
	Mon, 5 Nov 2001 02:53:02 -0500
Date: Mon, 5 Nov 2001 16:52:57 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre6 freeze mounting ext2 diskette
Message-ID: <Pine.LNX.4.30.0111051652300.5751-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just booted 2.4.14-pre6 and tried to mount a diskette with an ext2
filesystem on it.  /var/log/messages reported loading the correct
version of the module (floppy.o) and then it froze hard.  Left the disk
spinning.

kernel: FDC 0 is a post-1991 82077
<freeze>

Works fine under 2.4.12.  There was no fs damage.
/proc/ioports in 2.4.12 says:

  000003f0-000003f5 : floppy
  000003f7-000003f7 : floppy DIR

/etc/fstab entry:
/dev/fd0        /mnt/floppy     ext2    defaults,noauto,user    0 0

Alpha, gcc-3.0.1 compiled (so is 2.4.12).

