Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293199AbSCJTmx>; Sun, 10 Mar 2002 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293201AbSCJTmp>; Sun, 10 Mar 2002 14:42:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293199AbSCJTmg>; Sun, 10 Mar 2002 14:42:36 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Sun, 10 Mar 2002 19:41:36 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6gctg$eb6$1@penguin.transmeta.com>
In-Reply-To: <a6bjgl$a0j$1@cesium.transmeta.com> <E16jVSZ-0008FH-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 1015789335 22068 127.0.0.1 (10 Mar 2002 19:42:15 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Mar 2002 19:42:15 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16jVSZ-0008FH-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>So if anything its just not worth the effort of breaking the 386 setup
>either 8). 386 SMP is a different issue but I don't see any lunatics doing
>a 386 based sequent port thankfully.

Since the only person that comes to mind that would be crazy enough to
even _try_ to use Linux on 386-SMP is you, Alan, I'm really relieved to
hear you say that ;)

And no, it's not worth discontinuing i386 support.  It just isn't
painful enough to maintain. 

Note that the i386 has _long_ been a "stepchild", though: because of the
lack of WP, the kernel simply doesn't do threaded MM correctly on a 386. 
Never has, and never will. 

However, the known "incorrect" case is so obscure that it's not even an
issue - although I suspect that it means that you should not let
untrusted users run on a i386 server machine that contains any sensitive
data.  I could cerrtainly come up with exploits that would work at least
in theory (whether they are workable in practice I don't know). 

Using i386's for network servers is fine, of course.  Just don't use
them for cpu farms (not that I think anybody is - it takes quite a big
farm of i386 machines to equal even _one_ PII ;)

		Linus


