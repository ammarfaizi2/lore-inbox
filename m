Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272088AbRHVTTb>; Wed, 22 Aug 2001 15:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272092AbRHVTTK>; Wed, 22 Aug 2001 15:19:10 -0400
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:19119 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S272088AbRHVTTF>; Wed, 22 Aug 2001 15:19:05 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: State of PPC in kernel.org Sources?
Date: Wed, 22 Aug 2001 22:17:47 +0200
Message-Id: <20010822201747.12864@smtp.wanadoo.fr>
In-Reply-To: <20010822094440.B11350@borg.org>
In-Reply-To: <20010822094440.B11350@borg.org>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What is the state of Power PC support in Linus' kernels?  What about
>in -ac kernels?  
>
>I have noticed some recent PPC work in summaries of recent -ac kernels
>and wonder how intact it is.  Are they merges to keep PPC forks from
>drifting too far?  Are they merges to make furture back-ports from
>kernel.org to PPC forks easier?  Are they actually complete in and of
>themselves but lagging PPC forks?  (What about 405 support?  I think I
>see evidence of recent 405 activity in 2.4.8-ac4...)

There are no "PPC forks" ;) There is a PPC kernel tree on which
the work is done to merge all sources of PPC stuffs (embedded,
macs, other desktops, IBM high end...) and which is always in sync
with the latest Linus tree (well, it can be a few days off ;)

It's itself divided into a linuxppc_2_4 tree which contains
stable things that are in the process of beeing commited to the
main (Linus) tree, and linuxppc_2_4_devel which contains work
in progress stuffs (like new boards support, or whatever hacking
we PPC hackers that is more than fixing bugs).

This get regulary merged from _2_4_devel to _2_4 when they have
been tested enough. At that point, Paul Mackerras usually send
patches to Linus.

>I would love a short descreiption of the shape of this stuff.  What
>work happens where and how and when it moves elsewhere would be great
>to understand.  

Well, we have recently merged a bunch of new things from our "devel"
tree down to _2_4. When Linus is back, we'll bomb him with patches
to get his tree up-to-date.

The "embedded" support may be a little bit behind in _2_4 right now,
Dan Malek (Montavista) have updated  _2_4_devel recently with a
bunch of 4xx & 8xx updates, I can't tell for sure how stable they
are and when they may end up beeing in _2_4 or Linus tree. All I
can tell is that the current _2_4_devel on a 405GP board I'm working
on doesn't quite work yet (but is close to).

I'd suggest that until that's fixed, you stick to whatever kernel
you have (I beleive the previous 405GP port from Montavista, which
was a 2.4.2 base). 

Once it's fully merged in _2_4_devel, it will stay up-to-date
hopefully.

Finally, for more infos about those linuxppc_2_4 and linuxppc_2_4_devel,
or any other useful informations about linux on PPC, go
look at www.penguinppc.org ;)

Regards,
Ben.


Ben.


