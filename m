Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSI0DUC>; Thu, 26 Sep 2002 23:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSI0DUC>; Thu, 26 Sep 2002 23:20:02 -0400
Received: from thunk.org ([140.239.227.29]:9889 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261613AbSI0DUB>;
	Thu, 26 Sep 2002 23:20:01 -0400
Date: Thu, 26 Sep 2002 23:24:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020927032438.GA16159@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209261553.07593.ryan@completely.kicks-ass.org> <20020926235741.GC10551@think.thunk.org> <200209261800.27582.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209261800.27582.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 06:00:23PM -0700, Ryan Cumming wrote:
>
> > That's the only
> > thing that would explain the "write access enabled during recovery of
> > readonly filesystem" warning message.  That message means that
> > /dev/hda2 was readonly because the mount command *requested* that it
> > be mounted read-only, not because of some error.
> Would init remounting the filesystem read-only before a reboot explain that? 
> 11:49 is around the time I came to check my mail.

No, it doesn't.  The message "Filesystem recorded error from previous
mount" can only happen on an initial mount (which from the other
messages must have been a read-only mount), or on remount of a
read-only mount to a read-write mount.  Remounting read-only wouldn't
explain these syslogs.

						- Ted
