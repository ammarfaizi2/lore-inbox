Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131427AbRARUFi>; Thu, 18 Jan 2001 15:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131613AbRARUF1>; Thu, 18 Jan 2001 15:05:27 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:6927 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131427AbRARUFJ>; Thu, 18 Jan 2001 15:05:09 -0500
Date: Thu, 18 Jan 2001 22:18:38 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre8 slowdown on dbench tests 
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0101182208420.1729-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Marcelo Tosatti wrote:

> On my dbench runs I've noted a slowdown between pre4 and pre8 with 48
> threads. (128MB, 2 CPU's machine)

Below some kernel compile numbers on a 32 MB RAM + 32 MB swap box. The
three lines mean compilation with the -j1, -j2 and -j4 option. Most of
the time 2.4.1pre8 was also unable to compile the kernel because cc1
was killed by OOM handler.

	Szaka

2.2.18
548.27user 94.18system     10:50  98%CPU (450479major+696869minor)
548.94user 153.85system    11:51  98%CPU (487111major+704948minor)
599.44user 2018.66system   51:47  84%CPU (2295045major+1182819minor)
=========
2.4.0
557.18user 121.57system    11:25  99%CPU (442434major+705429minor)
551.76user 158.78system    12:11  97%CPU (446183major+711572minor)
579.65user 2860.53system 1:05:45  87%CPU (650964major+1209969minor)
===========
2.4.0+blk-13B
546.89user 140.35system    11:33  99%CPU (442435major+705424minor)
570.73user 188.51system    12:56  97%CPU (445171major+712791minor)
566.33user 2681.20system 1:02:26  86%CPU (654402major+1225784minor)
=================
2.4.1pre8
546.23user 118.81system    11:09  99%CPU (442434major+705424minor)
569.12user 161.25system    12:22  98%CPU (446667major+712457minor)
727.58user 2489.96system 1:25:34  62%CPU (616240major+1375321minor)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
