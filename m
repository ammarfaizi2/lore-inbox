Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSILTKE>; Thu, 12 Sep 2002 15:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSILTKD>; Thu, 12 Sep 2002 15:10:03 -0400
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:6280 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316857AbSILTKD>;
	Thu, 12 Sep 2002 15:10:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chuck Lever <cel@citi.umich.edu>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Thu, 12 Sep 2002 21:06:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu>
In-Reply-To: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pZID-0007jw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 21:04, Chuck Lever wrote:
> when locking or unlocking a file, the idea is to make sure that other
> clients can see all changes to the file that were made while it was
> locked.  locking and unlocking provide tighter cache coherency than simple
> everyday close-to-open because that's why applications go to the trouble
> of locking a file -- they expect to share the contents of the file with
> other applications on other clients.
> 
> when a file is locked, the client wants to be certain it has the latest
> version of the file for an application to play with.  the cache is purged
> to cause the client to read any recent changes from the server.  when a
> file is unlocked, the client wants to share its changes with other clients
> so it flushes all pending writes before allowing the unlocking application
> to proceed.

This is clear and easy to understand, thanks.

-- 
Daniel
