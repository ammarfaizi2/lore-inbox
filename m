Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287274AbSACNXX>; Thu, 3 Jan 2002 08:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSACNXN>; Thu, 3 Jan 2002 08:23:13 -0500
Received: from ep09.kernel.pl ([212.160.181.1]:44562 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S287274AbSACNXB>;
	Thu, 3 Jan 2002 08:23:01 -0500
Date: Thu, 3 Jan 2002 14:22:52 +0100
From: Michal Moskal <malekith@pld.org.pl>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange TCP stack behiviour with write()es in pieces
Message-ID: <20020103132252.GB21184@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 01:49:56PM -0800, David Schwartz wrote:
> 
> On Wed, 2 Jan 2002 17:28:06 +0100, Michal Moskal wrote:
> >I, personally, would expect the second version to be at most two times
> >slower (as there might be need to send two IP packets instead of one).
> >Also note, that as it is obvious that version with copying to buffer on the
> >stack should be faster, it is not so obvious if there is need to malloc()
> >buffer before sending (for example if there is no upper limit on len).
> >However even if we need to malloc() buffer, second version is still by
> >orders of magnitude faster.
> 
> 	If you can design an algorithm that makes that only two times slower, then 
> the world will be excited and interested and perhaps that algorithm will 
> replace TCP. But until that time, we're stuck with what we have.

With negle disabled it works 17/15 times slower, which is much less then
two. Similary with UNIX domain sockets.

> >I found it during work with client/server program that worked horribly slow
> >just becouse of this. (of course I fixed it, but that's not the point).
> 
> 	THAT IS THE POINT. The problem wasn't in the kernel, it was in the program, 
> and you fixed it. If you do smart buffering, TCP can behave efficiently. If 
> you don't, it has to guess when to send packets, and it can't possibly 
> predict the future and behave in the way you think is optimum.

Ok, *now* I know that ;)

Thank you all for pointers.

-- 
: Michal ``,/\/\,       '' Moskal    | |            : GCS {C,UL}++++$
:          |    |alekith      @    |)|(| . org . pl : {E--, W, w-,M}-
:    Linux: We are dot in .ORG.    |                : {b,e>+}++ !tv h
: CurProj: ftp://ftp.pld.org.pl/people/malekith/ksi : PLD Team member

