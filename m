Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280990AbRKGV0O>; Wed, 7 Nov 2001 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280994AbRKGV0I>; Wed, 7 Nov 2001 16:26:08 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:56974 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S280988AbRKGVYW>;
	Wed, 7 Nov 2001 16:24:22 -0500
Date: Wed, 7 Nov 2001 15:05:24 -0500
From: Theodore Tso <tytso@mit.edu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107150524.A489@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>; from roy@karlsbakk.net on Wed, Nov 07, 2001 at 04:00:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 04:00:55PM +0100, Roy Sigurd Karlsbakk wrote:
> hi
> 
> What's coolest/best/worst of ext3, ReiserFS and XFS?
> I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
> I see no difference at all. After a chrash, it really wants to run fsck
> anyway. 

It will run fsck after a crash, but the fsck simply runs the journal
on ext3 filesystems that were uncleanly mounted.  So the fsck will run
very quickly, *unless* the kernel had detected some kind of filesystem
error, and had set the "the filesystem has errors" flag, in which case
the full fsck check will be run.

If you're seeing a full fsck (i.e., a run which takes over a minute
and where you see the progress bar) after a crash consistently, you
might want to check and make sure that you've really converted the
filesystem in question to ext3.....

							- Ted


			
