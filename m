Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbSIWWiX>; Mon, 23 Sep 2002 18:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSIWWiX>; Mon, 23 Sep 2002 18:38:23 -0400
Received: from pat.uio.no ([129.240.130.16]:40926 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261441AbSIWWiW>;
	Mon, 23 Sep 2002 18:38:22 -0400
To: Daniel Phillips <phillips@arcor.de>
Cc: trond.myklebust@fys.uio.no, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D811A6C.C73FEC37@digeo.com> <3D8F6409.D45AA848@digeo.com>
	<15759.31838.68147.725840@charged.uio.no> <E17ta9C-0003bo-00@starship>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Sep 2002 00:43:06 +0200
In-Reply-To: <E17ta9C-0003bo-00@starship>
Message-ID: <shshegg1g5h.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Daniel Phillips <phillips@arcor.de> writes:

    >> Note that in doing so, we do not want to invalidate any reads
    >> or writes that may have been already scheduled. The existing
    >> mapping still would need to hang around long enough to permit
    >> them to complete.

     > With the mechanism I described above, that would just work.
     > The fault path would do lock_page, thus waiting for the IO to
     > complete.

NFS writes do not hold the page lock until completion. How would you
expect to be able to coalesce writes to the same page if they did?

Cheers,
  Trond
