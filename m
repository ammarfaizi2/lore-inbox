Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbRAPPyC>; Tue, 16 Jan 2001 10:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRAPPxn>; Tue, 16 Jan 2001 10:53:43 -0500
Received: from mons.uio.no ([129.240.130.14]:39072 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129792AbRAPPxi>;
	Tue, 16 Jan 2001 10:53:38 -0500
To: Mogens Kjaer <mk@crc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs client problem in kernel 2.4.0
In-Reply-To: <3A6466E3.AB55716@crc.dk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Jan 2001 16:53:25 +0100
In-Reply-To: Mogens Kjaer's message of "Tue, 16 Jan 2001 16:21:07 +0100"
Message-ID: <shsy9wb334a.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mogens Kjaer <mk@crc.dk> writes:


     > getdents64(3, /* 6 entries */, 65536) = 160
     > lseek(3, 1547825467, SEEK_SET) = 1547825467
     > ...
     > getdents64(3, /* 1 entries */, 65536)   = 32

I'll bet it's the lseek that's screwing things up again. IIRC IRIX has
an export option to cause it to generate 32-bit readdir cookies. Could
you please try enabling it?

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
