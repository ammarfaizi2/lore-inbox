Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRAaWP1>; Wed, 31 Jan 2001 17:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129062AbRAaWPR>; Wed, 31 Jan 2001 17:15:17 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:49674 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S129031AbRAaWPF>;
	Wed, 31 Jan 2001 17:15:05 -0500
X-Envelope-From: news@goldbach.in-berlin.de
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv problems in 2.4.0/2.4.1
Date: 31 Jan 2001 21:39:45 GMT
Organization: Strusel 007
Message-ID: <slrn97h1h1.13r.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <Pine.LNX.4.32.0101302104360.9417-100000@cheetah.STUDENT.cwru.edu> <Pine.BSO.4.30.0101310728000.1103-100000@getafix.lostland.net>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 980977185 17698 192.168.69.77 (31 Jan 2001 21:39:45 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 31 Jan 2001 21:39:45 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The card is a video only capture that came with a camera (and has a
> connector to power that camera next to the video connector).

Sure the box is really dead?  These very cheap cards with just the bt848
and nothing else often have a non-working i2c bus (because they have no
chips connected to it, maybe even the i2c pins unconnected).  The
i2c initialization takes forever (minutes) on these boards due to timeouts
and retries of the i2c code unless you tell the i2c layer it should make
some sanity checks on the i2c bus first (options i2c-algo-bit bit_test=1).

  Gerd

-- 
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
