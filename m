Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265165AbRF0AdL>; Tue, 26 Jun 2001 20:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265166AbRF0AdB>; Tue, 26 Jun 2001 20:33:01 -0400
Received: from mailout2-1.nyroc.rr.com ([24.92.226.165]:46689 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S265165AbRF0Acx>; Tue, 26 Jun 2001 20:32:53 -0400
Message-ID: <003f01c0fea2$39a64950$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Stefan Hoffmeister" <lkml.2001@econos.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.oqkojpv.3hosb7@ifi.uio.no> <fa.jpsks3v.1o2gag4@ifi.uio.no>
Subject: Re: VM Requirement Document - v0.0
Date: Tue, 26 Jun 2001 20:43:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Windows NT/2000 has flags that can be for each CreateFile operation
> ("open" in Unix terms), for instance
>
>   FILE_ATTRIBUTE_TEMPORARY
>   FILE_FLAG_WRITE_THROUGH
>   FILE_FLAG_NO_BUFFERING
>   FILE_FLAG_RANDOM_ACCESS
>   FILE_FLAG_SEQUENTIAL_SCAN
>

There is a BSD-originated convention for this - madvise().

If you look in the Linux VM code there is a bit of explicit code for
different madvise access patterns, but I'm not sure if it's 100% supported.

Drop-behind would be really, really nice to have for my multimedia
applications. I routinely deal with very large video files (several times
larger than my RAM). When I sequentially read though such files a bit at a
time, I do NOT want the old pages sitting there in RAM while all of my other
running programs are rudely paged out...

(hrm, maybe I could hack up my own manual read-ahead/drop-behind with mmap()
and memory locking...)

Regards,
Dan


