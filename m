Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315975AbSEZVvM>; Sun, 26 May 2002 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315985AbSEZVvL>; Sun, 26 May 2002 17:51:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315975AbSEZVvK>;
	Sun, 26 May 2002 17:51:10 -0400
Message-ID: <3CF15989.D6AA332C@zip.com.au>
Date: Sun, 26 May 2002 14:54:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter J. Braam" <braam@clusterfs.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [patch 11/18] dirsync
In-Reply-To: <3CF14973.B61EF771@zip.com.au> <20020526093637.V32110@lustre.cfs> <3CF15838.FE768070@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> "Peter J. Braam" wrote:
> >
> > Hi
> >
> > I think this patch is actually pretty important - could we please have
> > this, or something like this?
> >
> 
> Well `-o sync' will give the same result.  dirsync is just a speedup.
> 
> I should have mentioned: untarring a kernel tree with dirsync is 4x to
> 5x faster than `-o sync', but still tons slower (5x?) than default.

grr.  On ext2.  

On ext3, dirsync _is_ sync for journalled and ordered modes.  If you
run a commit, you sync the entire fs, end of story.  So dirsync on ext3
really only makes a difference in writeback mode.

-
