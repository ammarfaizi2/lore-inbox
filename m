Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270239AbTHGQbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTHGQbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:31:35 -0400
Received: from pdbn-d9bb86f3.pool.mediaWays.net ([217.187.134.243]:6671 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S270239AbTHGQbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:31:33 -0400
Date: Thu, 7 Aug 2003 18:31:14 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Oleg Drokin <green@namesys.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030807163114.GA1699@citd.de>
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com> <20030807132111.GB7094@louise.pinerecords.com> <20030807142312.GA901@citd.de> <20030807142544.GF20639@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807142544.GF20639@namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 06:25:44PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Aug 07, 2003 at 04:23:12PM +0200, Matthias Schniedermeyer wrote:
> > > > There is sort of "universal" fs convertor for linux that can convert almost
> > > > any fs to almost any other fs.
> > > > The only requirement seems to be that both fs types should have read/write support in Linux.
> > > > http://tzukanov.narod.ru/convertfs/
> > > I'm afraid I cannot recommend using this tool.
> > > A test conversion from reiserfs to ext3 (inside a vmware machine)
> > > screwed up the data real horrorshow: directory structure seems
> > > ok but file contents are apparently shifted.
> > That answers the question that poped up in my mind.
> > "How does the tool know where the blocks are, and in which order it can
> > 'move' then without corrupting the data.(*)
> 
> Well, there is FIBMAP ioctl that does this.
> 
> > Seems it doesn't know it.
> 
> It does. And our tests were more succesful, I believe.
> 
> > But it is possibel(*2) to do what the programm wants to do, you only
> > have to find out the order in which you have to copy the blocks to
> > prevent garbage. That's all the magic.
> 
> Sure.

Ups. Seems i am wrong, i "grep"ed for FIBMAP and the tool uses it. So i
guess the tool should be able to do everything correctly.

I take everything back and claim the opposite. :-)
(german idiom. "Ich nehm alles zurueck und behaupte das Gegenteil")




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

