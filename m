Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSDVRZA>; Mon, 22 Apr 2002 13:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314294AbSDVRY7>; Mon, 22 Apr 2002 13:24:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:1481 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314291AbSDVRY5>;
	Mon, 22 Apr 2002 13:24:57 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15556.18277.792115.379471@napali.hpl.hp.com>
Date: Mon, 22 Apr 2002 10:24:53 -0700
To: Pavel Machek <pavel@suse.cz>
Cc: davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020421180021.A155@toy.ucw.cz>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 21 Apr 2002 18:00:22 +0000, Pavel Machek <pavel@suse.cz> said:

  Pavel> .5% still looks like a lot to me. Good compiler optimization
  Pavel> is .5% on average...

Umh, but those optimizations are interesting only if they're
cumulative, i.e., once you've got 10 of them and they make a *total*
difference of 5% (actually, I'm doubtful anyone really notices
differences of 20-30% other than for benchmarking purposes... ;-).

For me, 1% is the magic threshold.  If we find real apps that get a
higher penalty than that, I'd either lower the HZ or see if we can
tune the timer tick to be within a safe margin.

No matter what, though, higher tick rate clearly incurs somewhat
higher overhead.  The benefit is lower application-level response time
and finer-granularity timeouts.  I assume Robert has all the
benchmarks to show that. ;-)

	--david
