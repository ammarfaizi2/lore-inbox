Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRDODuW>; Sat, 14 Apr 2001 23:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRDODuH>; Sat, 14 Apr 2001 23:50:07 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:34311 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132571AbRDODtg>;
	Sat, 14 Apr 2001 23:49:36 -0400
Date: Sat, 14 Apr 2001 23:49:27 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
X-X-Sender: <bart@localhost>
To: George Bonser <george@gator.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disorder?
In-Reply-To: <CHEKKPICCNOGICGMDODJGENKCLAA.george@gator.com>
Message-ID: <Pine.LNX.4.33.0104142347410.19694-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What kernel are you running?  This is disabled by default.  search for
where FASTRETRANS_DEBUG is enabled (should be in linux/include/net/tcp.h
and set it someting low (like 1 which is the default.  The actual error
message comes up in tcp_input.c (search fro FASTRETRANS_DEBUG).

Regards,
Bart.

On Sat, 14 Apr 2001, George Bonser wrote:

> What's all this in syslog? I don't remember ever seeing it there before.
>
> ...
> Apr 14 13:58:31 foo kernel: Disorder0 3 5 f0 s2 rr1
> Apr 14 13:58:32 foo kernel: Disorder0 3 5 f0 s1 rr1
> Apr 14 13:58:41 foo kernel: Disorder0 3 8 f0 s0 rr1
> Apr 14 13:58:44 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:58:45 foo kernel: Disorder0 3 4 f0 s0 rr1
> Apr 14 13:58:47 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:58:55 foo kernel: Disorder3 1 5 f5 s2 rr0
> Apr 14 13:58:59 foo kernel: Undo Hoe 145.236.164.120/2007 c3 l0 ss2/2 p3
> Apr 14 13:59:00 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:59:01 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:59:02 foo kernel: Undo Hoe 145.236.164.120/2007 c3 l0 ss2/2 p2
> Apr 14 13:59:02 foo kernel: Disorder0 3 4 f0 s0 rr1
> Apr 14 13:59:03 foo kernel: Undo Hoe 145.236.164.120/2007 c3 l0 ss2/2 p1
> Apr 14 13:59:04 foo kernel: Undo retrans 145.236.164.120/2007 c2 l0 ss2/2
> p0
> Apr 14 13:59:11 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:59:15 foo kernel: Disorder0 3 4 f0 s0 rr1
> Apr 14 13:59:17 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:59:19 foo kernel: Disorder0 3 4 f0 s0 rr1
> Apr 14 13:59:21 foo kernel: Disorder0 3 4 f0 s0 rr1
> Apr 14 13:59:24 foo kernel: Disorder0 3 7 f0 s0 rr1
> Apr 14 13:59:25 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:59:37 foo kernel: Disorder0 3 5 f0 s0 rr1
> Apr 14 13:59:57 foo kernel: Disorder3 1 5 f5 s2 rr0
> ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/

