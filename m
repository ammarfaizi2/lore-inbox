Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131463AbRASMA1>; Fri, 19 Jan 2001 07:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbRASMAR>; Fri, 19 Jan 2001 07:00:17 -0500
Received: from colorfullife.com ([216.156.138.34]:40203 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131463AbRASMAD>;
	Fri, 19 Jan 2001 07:00:03 -0500
Message-ID: <3A682C3C.B0F7E67E@colorfullife.com>
Date: Fri, 19 Jan 2001 12:59:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: More filesystem corruption under 2.4.1-pre8 and SW Raid5
In-Reply-To: <Pine.LNX.4.30.0101191222170.28348-100000@talentix.dwd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:

> > I'm running your test with 48 MB ram, 12500 files, 9 processes in a 156
> > MB partition (swapoff, here is the test partition ;-).
> > With 192MB Ram I don't see the corruption.
> >
> I am not sure if I understand you correctly: with 48MB you do get
> corruption and with 192MB not? And if you do see corruption are you
> using SW Raid, SMP?

Sorry for the confusion: The 'mem=48M' test was still running when I
wrote the last mail.

I don't see a corruption - neither with 192MB ram nor with 48 MB ram.
SMP, no SW Raid, ext2, but only 1024 byte/file and only 12500
files/directory.


> 
> With 10000 I also had no problem, my next step was 50000.
> 
10000 files need ~180MB, that fit's into the cache.
50000 files need ~900MB, that doesn't fit into the cache.

I'd try 10000 files, but now with "mem=64m"

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
