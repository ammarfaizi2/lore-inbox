Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSJVQ1x>; Tue, 22 Oct 2002 12:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSJVQ1x>; Tue, 22 Oct 2002 12:27:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39614 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S263366AbSJVQ1x>; Tue, 22 Oct 2002 12:27:53 -0400
Date: Tue, 22 Oct 2002 14:33:48 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
In-Reply-To: <3DB4855F.D5DA002E@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210221428060.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Andrew Morton wrote:

> He had 3 million dentries and only 100k pages on the LRU,
> so we should have been reclaiming 60 dentries per scanned
> page.
>
> Conceivably the multiply in shrink_slab() overflowed, where
> we calculate local variable `delta'.  But doubtful.

What if there were no pages left to scan for shrink_caches ?

Could it be possible that for some strange reason the machine
ended up scanning 0 slab objects ?

60 * 0 is still 0, after all ;)

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

