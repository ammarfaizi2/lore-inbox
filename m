Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291431AbSAaXt5>; Thu, 31 Jan 2002 18:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291434AbSAaXts>; Thu, 31 Jan 2002 18:49:48 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:61198 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291431AbSAaXti>;
	Thu, 31 Jan 2002 18:49:38 -0500
Date: Fri, 1 Feb 2002 10:44:17 +1100
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131234416.GB4138@krispykreme>
In-Reply-To: <Pine.LNX.4.33L.0201292059440.32617-100000@imladris.surriel.com> <E16VhjU-0005Vb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16VhjU-0005Vb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> That has some potential big wins beyond oracle. Some of the big number
> crunching algorithms also benefit heavily from 4Mb pages even when you
> try and minimise tlb misses.

There are further wins on some architectures, eg POWER has hardware
prefetch streams which terminate at a page boundary. With a 4kB pagesize
the prefetch engine will have to restart every 4kB, so we would want to
use 16MB pages if possible.

How would we allocate large pages? Would there be a boot option to
reserve an area of RAM for large pages only?

Anton
