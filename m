Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275332AbTHGOX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275343AbTHGOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:23:55 -0400
Received: from pdbn-d9bb86f3.pool.mediaWays.net ([217.187.134.243]:31758 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S275332AbTHGOX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:23:29 -0400
Date: Thu, 7 Aug 2003 16:23:12 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Oleg Drokin <green@namesys.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030807142312.GA901@citd.de>
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com> <20030807132111.GB7094@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807132111.GB7094@louise.pinerecords.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 03:21:11PM +0200, Tomas Szepe wrote:
> > [green@namesys.com]
> > 
> > > >Why do people ever want a "converter"?
> > > That's been discussed before.
> > > Because people don't have the resources (hard disk space, tape drives, 
> > > money)  to backup their data, and might still be interested in testing a 
> > > new filesystem. They might be willing to take a risk with the new fs 
> > > and converter. Amazing as it may sound, people do that. I am such a 
> > > tester, and I'd find a converter to be a useful tool. But since the 
> > > previous discussion on the subject concluded it'd be really hard to 
> > > impossible to write one, I guess I'll have to settle for new hard drive(s).
> > 
> > This is no longer true.
> > There is sort of "universal" fs convertor for linux that can convert almost
> > any fs to almost any other fs.
> > The only requirement seems to be that both fs types should have read/write support in Linux.
> > http://tzukanov.narod.ru/convertfs/
> 
> I'm afraid I cannot recommend using this tool.
> 
> A test conversion from reiserfs to ext3 (inside a vmware machine)
> screwed up the data real horrorshow: directory structure seems
> ok but file contents are apparently shifted.

That answers the question that poped up in my mind.

"How does the tool know where the blocks are, and in which order it can
'move' then without corrupting the data.(*)

Seems it doesn't know it.

But it is possibel(*2) to do what the programm wants to do, you only
have to find out the order in which you have to copy the blocks to
prevent garbage. That's all the magic.



*: I mean the point where it copies the data from the sparse-file to the
block-device.

*2: All you (theoretically) need is 1 free block, or you go over
temp-space(e.g. memory) somewhere else.


Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

