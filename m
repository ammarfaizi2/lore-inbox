Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289135AbSAGMjJ>; Mon, 7 Jan 2002 07:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289139AbSAGMjA>; Mon, 7 Jan 2002 07:39:00 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:44557 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289135AbSAGMiq>;
	Mon, 7 Jan 2002 07:38:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] truncate fixes
Date: Mon, 7 Jan 2002 13:41:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au> <20020107051259.L1561@athlon.random> <3C3923F5.485668AA@zip.com.au>
In-Reply-To: <3C3923F5.485668AA@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NZ5v-0001Pv-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 05:28 am, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > > (I think I'll add a buffer_mapped() test to this code as well.  It's
> > > a bit redundant because the fs shouldn't go setting BH_New and not
> > > BH_Mapped, but this code is _very_ rarely executed, and I haven't
> > > tested all filesystems...)
> > 
> > correct, it shouldn't be necessary. I wouldn't add it. if a fs breaks the
> > buffer_new semantics it's the one that should be fixed methinks.
> 
> You mean "don't be lazy.  Audit all the filesystems"?  Sigh.  OK.

Isn't this a job for BUG?

--
Daniel
