Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbTCKGIg>; Tue, 11 Mar 2003 01:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTCKGIg>; Tue, 11 Mar 2003 01:08:36 -0500
Received: from thunk.org ([140.239.227.29]:17077 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262834AbTCKGIf>;
	Tue, 11 Mar 2003 01:08:35 -0500
Date: Tue, 11 Mar 2003 01:19:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Corruption problem with ext3 and htree
Message-ID: <20030311061911.GF1965@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Martin Schlemmer <azarah@gentoo.org>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20030307063940.6d81780e.azarah@gentoo.org> <20030306234819.Q1373@schatzie.adilger.int> <20030309063345.47046254.azarah@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309063345.47046254.azarah@gentoo.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... can you help construct a test case that doesn't rely on the
presence of the Gentoo distribution?  Is there some way we can
instrument the python code so we can see the exact filesystem
operations (renames, deletions, moves, etc.) that is going on?  The
good news is that you say that you're able to reproduce it every
single time, which implies it's not a timing related problem.

> And for some reason its only with the Hash::Util* files that it have
> this problem.  Am assuming it might not be related to the filename
> itself ?

It could possibly be a hash value dependent problem, which case it
could be related to the filename.  That's not very likely, but it is
possible.  If you could send us the result of "dumpe2fs -h /dev/XXXX",
that would be useful.  In particular the last two lines:

  Default directory hash:   tea
  Directory Hash Seed:      407dbbca-8326-4bed-bc7c-bb0453f79049

The most important thing though is to be able to reduce the test case
to something which is slightly easier for us ext2/3 developers to run.  

						- Ted
