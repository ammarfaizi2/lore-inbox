Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271212AbRHOOTA>; Wed, 15 Aug 2001 10:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271211AbRHOOSt>; Wed, 15 Aug 2001 10:18:49 -0400
Received: from mail.fbab.net ([212.75.83.8]:3859 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S271200AbRHOOSi>;
	Wed, 15 Aug 2001 10:18:38 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: szaka@f-secure.com viro@math.psu.edu torvalds@transmeta.com linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 12.731718 secs)
Message-ID: <401901c12595$77273ea0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Szabolcs Szakacsits" <szaka@f-secure.com>,
        "Alexander Viro" <viro@math.psu.edu>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0108151427400.2660-100000@fs131-224.f-secure.com>
Subject: Re: 2.4.8 Resource leaks + limits
Date: Wed, 15 Aug 2001 16:20:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Szabolcs Szakacsits" <szaka@f-secure.com>
[snip]
>
> No, 2.4.8 seems to like to soft lockup in cases after it used up all
> swap. I also run some trivial memory stressing tests on a UP, 128 MB,
> 256 swap, 7 MB/sec UDMA disk subsytem box and after a couple of
> successful recovery [couple = max 1 in my case] the system soft locks.
> swap space was 0, no disk activity, CPU apparently spins in kswapd, all
> relevant zones, inactive_* had plenty free pages and no memory
> fragmentation. After it soft locked none of the VM stat value changed
> at all. Rik also called for help in another thread but the problem seems
> to be not out_of_memory() tuning (when to jump in) however either
> accounting bug or other (kswapd related?) thing - kernel stacks were a
> bit strange [using Right_ALT+Scroll_Lock when soft locked], like
> page_launder
> do_try_to_free_pages
> kswapd
> kswapd
> kswapd
>

Well as i said, my system _never_ locks up completly ( but it might look
that way because it's crawlin'-like-a-dog ).
The problem is that i can shh in as root, but not as any other user ( not
via login or su or either ).
Root always works, and mind you, this is _after_ the "attack", and the
system resources is back to normal as far as i can tell.

It leads me to think something is wrong with the nproc rlimit accounting or
something like that, maybe in the oom kill code?

> Szaka
>


Magnus


