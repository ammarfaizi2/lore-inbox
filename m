Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSHDNj4>; Sun, 4 Aug 2002 09:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSHDNj4>; Sun, 4 Aug 2002 09:39:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27140 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315266AbSHDNjz>; Sun, 4 Aug 2002 09:39:55 -0400
Date: Sun, 4 Aug 2002 10:42:03 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>,
       Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: question on dup_task_struct
In-Reply-To: <Pine.LNX.4.44.0208031829230.1549-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208041041220.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002, Linus Torvalds wrote:
> On Sat, 3 Aug 2002, Andrew Morton wrote:
> >
> > It's not a 1-order allocation.  I'll go back to sleep now.
>
> According to slabinfo, it's an order-2 allocation at least on SMP-x86,
> which is kind of sad. The object size is 1664 bytes, and the slab code
> decides that putting two of them per page is too wasteful, so it
> apparently puts 9 of them on 4 pages instead.

> So I think it should be just GFP_KERNEL.

Trying a little bit of active defragmentation for 4 and 8-page
allocations should be trivial with rmap.  If you want I could
take a stab at writing this code.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

