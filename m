Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263700AbSJGWjt>; Mon, 7 Oct 2002 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263701AbSJGWjt>; Mon, 7 Oct 2002 18:39:49 -0400
Received: from tonnant.concentric.net ([207.155.248.72]:14261 "EHLO
	tonnant.cnchost.com") by vger.kernel.org with ESMTP
	id <S263700AbSJGWjs>; Mon, 7 Oct 2002 18:39:48 -0400
From: "Stuart Inglis" <stuart@reeltwo.com>
To: <linux-kernel@vger.kernel.org>
Subject: Floppy Raid
Date: Tue, 8 Oct 2002 11:45:14 +1300
Message-ID: <002101c26e53$37df09a0$2a01410a@nz.reeltwo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been playing with RAID over floppy (2x3.5" /dev/fd0, /dev/fd1) and
have a few questions. (With 2.4.18)

It seems clear that you can only read/write to one floppy device at a
time. Is this a hardware limit or a linux limit? fdformat to a single
drive takes around 100 seconds, whereas running two fdformats in
parallel takes close to 400 seconds (2.4.18). It looks like this is
because the lock changes when the fdformat switches from writing to
verifying.

While I have /dev/md0 setup with RAID-1 over fd0 and fd1, fdformat
/dev/fd0 fails nicely with "Device or resource busy". But I can still
mount /mnt/floppy and write to it... The changes appear on the
/mnt/floppy but not /dev/md0 until I unmount /mnt/floppy. Should this be
allowed to happen?

Cheers
Stuart


