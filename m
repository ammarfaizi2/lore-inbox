Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280016AbRKJIQf>; Sat, 10 Nov 2001 03:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280508AbRKJIQ0>; Sat, 10 Nov 2001 03:16:26 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:62817 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S280016AbRKJIQS>; Sat, 10 Nov 2001 03:16:18 -0500
Message-ID: <01bf01c169be$34305510$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Ben Israel" <ben@genesis-one.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.jmrptbv.1dh8ur1@ifi.uio.no>
Subject: Re: Disk Performance
Date: Sat, 10 Nov 2001 03:03:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why does my 40 Megabyte per second IDE drive, transfer
> files at best at 1-2 Megabytes per second?

Keep in mind that some disk benchmarks just read/write long contiguous
regions of the disk, whereas the files you are copying may be fragmented.
So, while your drive may be able to sustain 40 MB/sec on a contiguous
region, it might slow down a lot if it has to seek to different parts of a
fragmented file, or between many files.

Actually while I'm on this subject - does anyone have experience with
"preallocating" files for low-latency transfers? e.g. if I know I'm going to
capture several GB of video to disk, will it reduce I/O latency if I
truncate the destination file to the proper size and fill it with zeros
beforehand? (I assume it helps for the fs to be as empty as possible) Are
any filesystems particularly good/bad for cases like this?

Regards,
Dan

