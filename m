Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSEUMaX>; Tue, 21 May 2002 08:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEUMaW>; Tue, 21 May 2002 08:30:22 -0400
Received: from 216-42-72-145.ppp.netsville.net ([216.42.72.145]:19162 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S313711AbSEUMaW>; Tue, 21 May 2002 08:30:22 -0400
Subject: Re: [reiserfs-dev] [patch 5/15] reiserfs locking fix
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
In-Reply-To: <3CE7FF5A.FEDD69CB@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 21 May 2002 08:29:05 -0400
Message-Id: <1021984145.22608.173.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-19 at 15:39, Andrew Morton wrote:
> 
> 
> reiserfs is using b_inode_buffers and fsync_buffers_list() for
> attaching dependent buffers to its journal.  For writeout prior to
> commit.
> 
> This worked OK when a global lock was used everywhere, but the locking
> is currently incorrect - try_to_free_buffers() is taking a different
> lock when detaching buffers from their "foreign" inode.  So list_head
> corruption could occur on SMP.

Thanks Andrew, this is working for me here.

-chris


