Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRAFKac>; Sat, 6 Jan 2001 05:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130427AbRAFKaV>; Sat, 6 Jan 2001 05:30:21 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:11792 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S130392AbRAFKaE>;
	Sat, 6 Jan 2001 05:30:04 -0500
X-Envelope-From: news@goldbach.in-berlin.de
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
Date: 6 Jan 2001 09:47:45 GMT
Organization: Strusel 007
Message-ID: <slrn95dqe1.ne.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <E14EZMf-0007vp-00@the-village.bc.nu> <3A55F6DB.24041B4C@rochester.rr.com>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 978774465 7287 192.168.69.77 (6 Jan 2001 09:47:45 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 6 Jan 2001 09:47:45 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> last 2 lines in dmesg output:
> mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000
> mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000

both *fb fbcon drivers and xfree 4 try to setup mtrr ranges, which
are the same for the video card => mtrr complains because the entry
is already there.

  Gerd

-- 
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
