Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318421AbSGYLl2>; Thu, 25 Jul 2002 07:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318423AbSGYLl2>; Thu, 25 Jul 2002 07:41:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47022 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318421AbSGYLl1>;
	Thu, 25 Jul 2002 07:41:27 -0400
Date: Thu, 25 Jul 2002 07:44:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
In-Reply-To: <Pine.LNX.4.44.0207242222410.1231-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0207250739390.17037-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002, Linus Torvalds wrote:

> Note that there is one place where 64 bits is simply _too_ expensive, and
> that's the page cache. In particular, the "index" in "struct page". We
> want to make "struct page" _smaller_, not larger.
> 
> Right now that means that 16TB really is a hard limit for at least some
> device access on a 32-bit machine with a 4kB page-size (yes, you could
> make a filesystem that is bigger, but you very fundamentally cannot make
> individual files larger than 16TB).

ITYM "8Tb" - indices are signed, IIRC.  OTOH, it's not 2^31 * PAGE_SIZE -
it's 2^31 * PAGE_CACHE_SIZE, which can be bigger.

Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
device should seek professional help of the kind they don't give on l-k...

