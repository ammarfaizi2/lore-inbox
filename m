Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbRAPQFI>; Tue, 16 Jan 2001 11:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131161AbRAPQE6>; Tue, 16 Jan 2001 11:04:58 -0500
Received: from mons.uio.no ([129.240.130.14]:10913 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130820AbRAPQEr>;
	Tue, 16 Jan 2001 11:04:47 -0500
To: Mogens Kjaer <mk@crc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs client problem in kernel 2.4.0
In-Reply-To: <3A6466E3.AB55716@crc.dk> <shsy9wb334a.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Jan 2001 17:04:43 +0100
In-Reply-To: Trond Myklebust's message of "16 Jan 2001 16:53:25 +0100"
Message-ID: <shsu26z32lg.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> " " == Mogens Kjaer <mk@crc.dk> writes:
    >> getdents64(3, /* 6 entries */, 65536) = 160 lseek(3,
    >> 1547825467, SEEK_SET) = 1547825467 ...  getdents64(3, /* 1
    >> entries */, 65536) = 32

BTW: there does in any case seem to be a bug in your version of
glibc. getdents64() is returning 64-bit file offsets, so they're not
going to fit with ordinary lseek().

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
