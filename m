Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSI1ONx>; Sat, 28 Sep 2002 10:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbSI1ONx>; Sat, 28 Sep 2002 10:13:53 -0400
Received: from thunk.org ([140.239.227.29]:19875 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261570AbSI1ONw>;
	Sat, 28 Sep 2002 10:13:52 -0400
Date: Sat, 28 Sep 2002 10:18:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020928141841.GB653@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <E17uINs-0003bG-00@think.thunk.org> <20020926235741.GC10551@think.thunk.org> <20020927041234.GS22795@clusterfs.com> <200209271820.41906.ryan@completely.kicks-ass.org> <20020928141330.GA653@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020928141330.GA653@think.thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, one other thing.  I'm pretty sure the rest of the errors you saw
were a result of the fact that you had your filesystem set to remount
the filesystem read-only after running into errors.  When the error
was detected, all existing updates to the filesystem are aborted (to
minimize damage to the filesystem), and that can leave the filesystem
in a somewhat inconsistent state, although nothing which e2fsck
shouldn't be able to fix.  

When running with the filesystem set to continue-with-errors, the only
problem which e2fsck picks up is the too-small-to-be-sane directory
entry problem.

						- Ted

