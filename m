Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbRFZVd6>; Tue, 26 Jun 2001 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbRFZVds>; Tue, 26 Jun 2001 17:33:48 -0400
Received: from alpo.casc.com ([152.148.10.6]:9457 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S265108AbRFZVdb>;
	Tue, 26 Jun 2001 17:33:31 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15160.65442.682067.38776@gargle.gargle.HOWL>
Date: Tue, 26 Jun 2001 17:33:22 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jason McMullan <jmcmullan@linuxcare.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <Pine.LNX.4.33L.0106261819400.23373-100000@duckman.distro.conectiva>
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com>
	<Pine.LNX.4.33L.0106261819400.23373-100000@duckman.distro.conectiva>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> * If we're getting low cache hit rates, don't flush
>> processes to swap.
>> * If we're getting good cache hit rates, flush old, idle
>> processes to swap.

Rik> ... but I fail to see this one. If we get a low cache hit rate,
Rik> couldn't that just mean we allocated too little memory for the
Rik> cache ?

Or that we're doing big sequential reads of file(s) which are larger
than memory, in which case expanding the cache size buys us nothing,
and can actually hurt us alot.  

I personally don't feel that the cache should be allowed to grow over
50% of the system's memory at all, we've got so much in the cache at
that point, that we're probably not hitting it all that much.

This is why the discussion on the other cache scanning algorithm
(2Q+?) was so interesting, since it looked to handle both the LRU
vs. FIFO tradeoffs very nicely.  

Rik> I am very much interested in continuing this discussion...

Me too, even if I can just contribute comments and not much code.  

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
