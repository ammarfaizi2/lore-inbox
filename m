Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbSIYMre>; Wed, 25 Sep 2002 08:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261971AbSIYMrd>; Wed, 25 Sep 2002 08:47:33 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:22504 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261970AbSIYMrd>;
	Wed, 25 Sep 2002 08:47:33 -0400
Date: Wed, 25 Sep 2002 22:52:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps forever)
Message-Id: <20020925225230.0028639b.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
References: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002 12:58:11 +0200 (CEST) Karel Gardas <kgardas@objectsecurity.com> wrote:
>
> I have problem with resume from suspend on IBM T22 with kernel 2.4.19
> patched with rmap-14a and usagi-20020916. Actually the problem is that OS
> resume well from suspend (it prints some messages to console for example
> from FW droping some packets), but harddisc is still sleeping and never
> wake up...

I have a T22 and run 2.4.20-pre5 and 2.4.19-pre8 with no patches and
have no problems resuming from suspend.

> Kernel is compiled with frame-buffer support and I always run XFree now at
> version 4.1.0. I've tested suspend/resume cycle with X and without them
> but the behavior is still the same - harddisc sleeps forever (or to reset)
> - as I said kernel seems to run, there is 50-70% chance that console
> (graphics) resume well and so I'm even able to type some command into
> xterm (like cd /usr; find), but then it hangs on sleeping harddisc. Magic
> system request keys are working too.

My system is set up to always switch VTs (away from X) when it suspends
and back when it resumes.

> Kernel is compiled with Debian's gcc 2.95.4/binutils 2.12.90.0.1. Full
> config is attached to this email. I have to add that I've not experienced
> such problems with 2.4.18 - patched with older version of usagi and
> rmap-12<something> yet. It always waits a bit after resume, but harddrive
> is always finally woken up.
> 
> Any other information which I have to provide you for better debugging
> this problem?

All I can suggest is that you try 2.4.19 without any patches, then with
the rmap patch and then with only the USAGI patch and see if that makes
any difference.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
