Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292331AbSBBRqR>; Sat, 2 Feb 2002 12:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSBBRqH>; Sat, 2 Feb 2002 12:46:07 -0500
Received: from mustard.heime.net ([194.234.65.222]:64684 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292331AbSBBRp5>; Sat, 2 Feb 2002 12:45:57 -0500
Date: Sat, 2 Feb 2002 18:45:45 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Roger Larsson <roger.larsson@norran.net>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed 
In-Reply-To: <200202021732.g12HWMU25229@mailc.telia.com>
Message-ID: <Pine.LNX.4.30.0202021843430.11440-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew did supply a patch for Riel but he did not accept all of it?
>
> Lets see again. Do I understand you correctly:
> rmap 11c fixes the problem #1 but not 11b? are all later
> rmaps good?

I've just tried 11c and 12a. Both are good. The change was made between
11b and 11c.

>
> rmap 11c:
>   - oom_kill race locking fix                             (Andres Salomon)
>   - elevator improvement                                  (Andrew Morton)
>   - dirty buffer writeout speedup (hopefully ;))          (me)
>   - small documentation updates                           (me)
>   - page_launder() never does synchronous IO, kswapd
>     and the processes calling it sleep on higher level    (me)
>   - deadlock fix in touch_page()                          (me)
> rmap 11b:
>
> Lets see, not oom condition, no dirty buffers (read "only"),
> not documentation, page_launder (no dirty...), not deadlock.
> Remaining is the elevator... And that can really be it!
> (read ahead related too...)
>
> and 2.4.18-pre2 (or later) does not fix it?

I'll try.

>
> 2.4.18-pre2:
> - ...
> - Fix elevator insertion point on failed
>   request merge					(Jens Axboe)
> - ...
> pre1:

btw... I beleive the error #2 is Tux specific. I'm debugging it now. Sorry
for that

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

