Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSIZDXW>; Wed, 25 Sep 2002 23:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbSIZDXV>; Wed, 25 Sep 2002 23:23:21 -0400
Received: from thunk.org ([140.239.227.29]:38559 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262158AbSIZDXT>;
	Wed, 25 Sep 2002 23:23:19 -0400
Date: Wed, 25 Sep 2002 23:27:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926032756.GA4072@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <3D923E88.30104@pobox.com> <20020925232949.GA15765@think.thunk.org> <200209251645.40575.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209251645.40575.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 04:45:34PM -0700, Ryan Cumming wrote:
> I got some pretty nasty results with that patch. After enabling the
> dir_index superblock flag and running e2fsck -fD, the filesystem
> would spontaneously remount itself read-only (I have
> errors=remount-ro set) after a few minutes of use. Once I disabled
> dir_index, e2fsck picked up many duplicate blocks.  There doesn't
> appear to be any severe filesystem damage, however.

Well, I'm currently running with 2.4.19 with the ext3 patch, and I'm
not having any problems.  In fact, my mail directory is an indexed
directory, and I'm replying out of it at this very moment.  I've also
done a number of fairly intensive bitkeeper operations (the
deleted/SCCS directory gets is pretty big for the linux kernel), and
it seems to be working just fine for me.

Are you sure you upgraded to the latest version of e2fsprogs (version
1.29, released yesterday?).  I specified version 1.29 explicitly in my
last e-mail for a reason --- e2fsprogs 1.28 had a bug where e2fsck -fD
had a 1 in 512 chance of corrupting each directory block which it
tries to optimize.  Unfortunately because the fence post error had
only a 1 in 512 chance of triggering, I didn't notice it in my
regression tests.

							- Ted
