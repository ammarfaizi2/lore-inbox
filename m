Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284428AbRLEOir>; Wed, 5 Dec 2001 09:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284430AbRLEOii>; Wed, 5 Dec 2001 09:38:38 -0500
Received: from mail.spylog.com ([194.67.35.220]:55168 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S284425AbRLEOi3>;
	Wed, 5 Dec 2001 09:38:29 -0500
Date: Wed, 5 Dec 2001 17:38:52 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <81181418686.20011205173852@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        theowl@freemail.c3.hu, <theowl@freemail.hu>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <20011204175504.E3447@athlon.random>
In-Reply-To: <16498470022.20011204183624@spylog.ru>
 <Pine.LNX.4.33L.0112041439210.4079-100000@imladris.surriel.com>
 <20011204175504.E3447@athlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

>>
>> OTOH, I doubt it would help real-world workloads where the
>> application maps and unmaps areas of different sizes and
>> actually does something with the memory instead of just
>> mapping and unmapping it ;)))

AA> exactly, while that would be simple to implement and very lightweight at
AA> runtime, that's not enough to mathematically drop the complexity of the
AA> get_unmapped_area algorithm. It would optimize only the case where
AA> there's no fragmentation of the mapped virtual address space.

And also will optimize all mappings of 4K and (which are at least 70%
in mu case) :)

AA> For finding the best fit in the heap with O(log(N)) complexity (rather
AA> than the current O(N) complexity of the linked list) one tree indexed by
AA> the size of each hole would be necessary.

This of course would be the best way.


-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

