Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276922AbRJQPRx>; Wed, 17 Oct 2001 11:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276920AbRJQPRo>; Wed, 17 Oct 2001 11:17:44 -0400
Received: from alpo.casc.com ([152.148.10.6]:1001 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S275765AbRJQPRf>;
	Wed, 17 Oct 2001 11:17:35 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15309.41257.742722.320262@gargle.gargle.HOWL>
Date: Wed, 17 Oct 2001 11:18:01 -0400
To: Robert Cohen <robert.cohen@anu.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au>
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ lots of wonderful problem tracking deleted. ]

Robert> Factor 4: the performance problem only occurs with small
Robert> writes.  Evidence: the test programs I posted yesterday were
Robert> doing IO with 8K buffers (set by a define) because that was
Robert> what the original benchmark I was emulating did. If I modify
Robert> "receive" to use a 64k buffer, I get adequate throughput.  The
Robert> anomalous reads are still happening, but don't seem to impact
Robert> performance too much. The throughput ramps smoothly between 8k
Robert> and 64k buffers.

I'm not a kernel hacker either, but I wonder what happens when you
scale your buffers above and below your ranges.  I.e. what happens
with 1k, 2k, 4k, 128k, 256k buffers?  Do you get a linear (or at least
a smooth curve) change between these values?

I also wonder about whether using TCP vs. UDP packets over sockets
makes any difference in your testing.  More tests for you to write and
do, but it might help narrow down where the bad interaction is really
happening.

Good luck,
John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548

