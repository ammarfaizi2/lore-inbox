Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317167AbSEXO6S>; Fri, 24 May 2002 10:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317166AbSEXO6R>; Fri, 24 May 2002 10:58:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37129 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317165AbSEXO6P>; Fri, 24 May 2002 10:58:15 -0400
Date: Fri, 24 May 2002 16:58:17 +0200
From: Jan Kara <jack@suse.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020524145817.GC31925@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020523091626.GA8683@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205231002460.1006-100000@home.transmeta.com> <20020524123510.A180298@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi all,
  
> On Thu, May 23, 2002 at 10:03:50AM -0700, Linus Torvalds wrote:
> > 
> > On Thu, 23 May 2002, Jan Kara wrote:
> > > ... . If he has newer tools
> > > (<3.05) he has to decide depending on format he wants to use...
>                       ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> > This makes me pretty certain we just do not want to have the backwards-
> > compatibility layer in 2.5.x
> > 
> > Are there _any_ reasons to use the old stuff, if the fix is just to
> > upgrade to a newer quota tool?
> 
> Moving to newer interfaces implies use of the new ondisk format
> for the quota files (exclusively) - I'd imagine that's the main
> reason behind providing a choice.  Whether or not that reason is
> sufficently compelling though... dunno.  If one wanted to be able
> to switch between booting either 2.4 (unpatched) and 2.5+, and
> also maintain quota information on filestystems, then the choice
> would be useful in that situation.
  Latest quota interface is able to handle both formats together
(structures passed throught Q_GETQUOTA, Q_SETQUOTA,... are independent
of quota format and Q_QUOTAON takes as an argument in 'id' the quota format
number). So if user wants to stay at old format he can...
  So I think Linus is right here that there's no real reason for keeping
compatibility code in 2.5... Linus, I'll send you the patch which kicks
out the compatibility stuff.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
