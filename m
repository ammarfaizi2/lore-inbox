Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSEYXjt>; Sat, 25 May 2002 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEYXjs>; Sat, 25 May 2002 19:39:48 -0400
Received: from bs1.dnx.de ([213.252.143.130]:59050 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315455AbSEYXjq>;
	Sat, 25 May 2002 19:39:46 -0400
Date: Sun, 26 May 2002 01:16:20 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526011620.C598@schwebel.de>
In-Reply-To: <20020525133637.B17573@work.bitmover.com> <20020525205139.D283611972@denx.denx.de> <20020525140532.A11297@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 02:05:32PM -0700, Larry McVoy wrote:
> s/same core idea/same core code/

Not true. Please note that the RTHAL (Realtime Hardware Abstraction Layer)
which is the core of RTAI was even available under DOS in Paolo
Mantegazza's group before it was ported to Linux. 

> Go search around, get the code you can still find on the net and start
> diffing. 

This may be true for early versions of RTAI, where everybody thought that
we are all working together in a friendly way as we have been used to in
the Linux community. 

The core has been completely reworked since then¹ - and it nevertheless is
under the GPL, so there is absolutely no problem with that. When there came
up doubts about the legal status of the stuff being under the LGPL in
former times the RTAI team has immediately investigated this, with the
result of the license situation we have today. 

> So not only do the RTAI people have an issue with the patent, it looks
> like they'd better be conforming to the GPL as well.

We do. Show us where we don't and we will immediately change it. 

> Didn't RTAI switch the copyright on "their" sourcebase to LGPL? 

It's different. There is the RTHAL patch, which goes into the kernel. This
one is GPL, as well as the HRT schedulers. 

All the infrastructure modules providing things like FIFOs, mailboxes,
tasklets and stuff are under the LGPL, meaning "give back when modifying
it, but be able to built something ontop of it which doesn't have to be
free". 

Robert
¹ There are surely small things which cannot be implemented in 
  another way - try to write a counting loop in another way than 
  for (i=0; i<N; i++) {printf(i);}
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
