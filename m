Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133092AbRANTA3>; Sun, 14 Jan 2001 14:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbRANTAN>; Sun, 14 Jan 2001 14:00:13 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:52740 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S133089AbRANS7w>;
	Sun, 14 Jan 2001 13:59:52 -0500
Date: Sun, 14 Jan 2001 18:59:57 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, getting closer
In-Reply-To: <Pine.LNX.4.30.0101141636350.6714-301000@svea.tellus>
Message-ID: <Pine.LNX.4.30.0101141848330.7031-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should also add that the 3.11 driver seems to make things better, but
not yet perfect.  My intuition tells me that I get CRC errors much sooner
with 2.1e than with 3.11.

Has the timings changed from 2.1e to 3.11, and would it be easy to modify
3.11 to get extra safe/paranoid, but less high performance, timings?

Some extra data:
* B seems to work in 2 with udma2
* A seems to work in 2 with udma1, but not with udma2.

I wouldn't say it's rock solid, and I would not trust my data to any of
these combinations, but at least it not break immmediately (i.e. for less
than 1 GB written).

The worst combination is 2.4.0 with VIA 2.1e and A in 1.  Going from 2.1e
to 3.11 helps, but it is still very bad.

I'd really like to be more precise, but there are too many combinations to
try to try them all, and sometimes it fails right away, and sometimes
after several hundred megabytes.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
