Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTIGKIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 06:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTIGKIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 06:08:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5071 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262947AbTIGKIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 06:08:51 -0400
Date: Sun, 7 Sep 2003 12:08:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.0-test4-mm5 and below: Wine and XMMS problems
Message-ID: <20030907100843.GM14436@fs.tum.de>
References: <20030902231812.03fae13f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902231812.03fae13f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 11:18:12PM -0700, Andrew Morton wrote:
>...
> . Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
>   in evaluating the stability, efficacy and relative performance of Nick's
>   work.
> 
>   We're looking for feedback on the subjective behaviour and on the usual
>   server benchmarks please.
>...

Short story:

I'm still using 2.5.72, all of the 2.6.0-test?{,-mm?} kernels have 
problems


Long story:

System:
K6-2 @ 500 MHz
128 MB RAM
1 GB swap
Debian unstable

Workload:
XFree86
FVWM
XMMS
Wine running "Master of Orion 2" (a round based space strategy game)

With 2.4 kernels and 2.5.72 everything works fine.

With 2.6.0-test? and 2.6.0-test?-mm? kernels up to 2.6.0-test4-mm4 the
XMMS sound sometimes skips or sounds slow (like when wou manually retard
a record). That's much more awful than skips.

RAM usage is low, even after a "swapoff -a" at about half of my RAM
would be enough.

The problems might be related to the fact that after I start Wine three
wine.bin processes run and each of them tries to get as much CPU time as
possible.

It might be part of the problem that although Wine is the interactive 
task a working XMMS is subjectively more important.

With 2.6.0-test4-mm5 these problems don't occur. Instead, Wine feels 
slow. I couldn;t test it much since after the first fast mouse movement 
the X mouse cursor has lost the mouse cursor of the game (this might be 
a bug in Wine, but it doesnt occur with other kernels).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

