Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSIET4S>; Thu, 5 Sep 2002 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSIET4S>; Thu, 5 Sep 2002 15:56:18 -0400
Received: from mons.uio.no ([129.240.130.14]:50650 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318069AbSIET4S>;
	Thu, 5 Sep 2002 15:56:18 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <3D77A22A.DC3F4D1@zip.com.au>
	<Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>
	<3D77ADC3.938C09F8@zip.com.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 05 Sep 2002 22:00:44 +0200
In-Reply-To: <3D77ADC3.938C09F8@zip.com.au>
Message-ID: <shsvg5k9pg3.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > You may have more success using the stronger
     > invalidate_inode_pages2().

Shouldn't make any difference. Chuck is seeing this on readdir() pages
which, of course, don't suffer from problems of dirtiness etc on NFS.

I've noticed that the code that used to clear page->flags when we
added a page to the page_cache has disappeared. Is it possible that
pages are being re-added with screwy values for page->flags?

Cheers,
  Trond
