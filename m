Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSFCWiK>; Mon, 3 Jun 2002 18:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSFCWiJ>; Mon, 3 Jun 2002 18:38:09 -0400
Received: from 216-42-72-145.ppp.netsville.net ([216.42.72.145]:27265 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315634AbSFCWiI>; Mon, 3 Jun 2002 18:38:08 -0400
Subject: Re: [patch 12/16] fix race between writeback and unlink
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206031514110.868-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Jun 2002 18:36:23 -0400
Message-Id: <1023143783.31682.28.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 18:19, Linus Torvalds wrote:
> 
> 
> On 3 Jun 2002, Chris Mason wrote:
> >
> > Or am I missing something?
> 
> No. I think that in the long run we really would want all of the writeback
> preallocation should happen in the "struct file", not in "struct inode".
> And they should be released at file close ("release()"), not at iput()
> time.

reiserfs does preallocation and tail packing in release() right now, but
do we really need preallocation at all once delayed allocation is
stable?

-chris


