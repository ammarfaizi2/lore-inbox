Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135529AbRDSDSc>; Wed, 18 Apr 2001 23:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135531AbRDSDSX>; Wed, 18 Apr 2001 23:18:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51661 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135529AbRDSDSP>;
	Wed, 18 Apr 2001 23:18:15 -0400
Date: Wed, 18 Apr 2001 23:18:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@nl.linux.org>, jaharkes@cs.cmu.edu,
        adilger@turbolinux.com, ext2-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Ext2 Directory Index - Delete Performance
In-Reply-To: <Pine.LNX.4.21.0104190001560.1685-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.GSO.4.21.0104182316090.15153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Rik van Riel wrote:

> Hmmm, considering this, it may be wise to limit the amount of
> inodes in the inode cache to, say, 10% of RAM ... because we
> can cache MORE inodes if we store them in the buffer cache
> instead!

Rik, I'd rather check the effect of prune_icache() patch before
deciding what to do. It doesn't make much sense to limit icache
size when we leave unused inodes for a long time.

