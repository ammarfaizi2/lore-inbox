Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275300AbTHGOZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275334AbTHGOZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:25:46 -0400
Received: from angband.namesys.com ([212.16.7.85]:22966 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275300AbTHGOZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:25:45 -0400
Date: Thu, 7 Aug 2003 18:25:44 +0400
From: Oleg Drokin <green@namesys.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Tomas Szepe <szepe@pinerecords.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030807142544.GF20639@namesys.com>
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu> <20030807072751.GA23912@namesys.com> <20030807132111.GB7094@louise.pinerecords.com> <20030807142312.GA901@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807142312.GA901@citd.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Aug 07, 2003 at 04:23:12PM +0200, Matthias Schniedermeyer wrote:
> > > There is sort of "universal" fs convertor for linux that can convert almost
> > > any fs to almost any other fs.
> > > The only requirement seems to be that both fs types should have read/write support in Linux.
> > > http://tzukanov.narod.ru/convertfs/
> > I'm afraid I cannot recommend using this tool.
> > A test conversion from reiserfs to ext3 (inside a vmware machine)
> > screwed up the data real horrorshow: directory structure seems
> > ok but file contents are apparently shifted.
> That answers the question that poped up in my mind.
> "How does the tool know where the blocks are, and in which order it can
> 'move' then without corrupting the data.(*)

Well, there is FIBMAP ioctl that does this.

> Seems it doesn't know it.

It does. And our tests were more succesful, I believe.

> But it is possibel(*2) to do what the programm wants to do, you only
> have to find out the order in which you have to copy the blocks to
> prevent garbage. That's all the magic.

Sure.

Bye,
    Oleg
