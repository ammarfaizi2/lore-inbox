Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291444AbSBHGvd>; Fri, 8 Feb 2002 01:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291445AbSBHGvX>; Fri, 8 Feb 2002 01:51:23 -0500
Received: from [63.231.122.81] ([63.231.122.81]:1591 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291444AbSBHGvJ>;
	Fri, 8 Feb 2002 01:51:09 -0500
Date: Thu, 7 Feb 2002 23:49:36 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Larry McVoy <lm@work.bitmover.com>, Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207234936.K15496@lynx.turbolabs.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com> <20020207092640.P27932@work.bitmover.com> <20020207232858.M17426@altus.drgw.net> <20020207220619.A18469@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207220619.A18469@work.bitmover.com>; from lm@bitmover.com on Thu, Feb 07, 2002 at 10:06:19PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07, 2002  22:06 -0800, Larry McVoy wrote:
> > Ideally, this should ask what changesets you want to send, and what 
> > public tree to look at to see *what* makes sense to send.
> 
> In BK 2.1.4 we added a 
> 
> 	bk send -u<url> email
> 
> which does the sync with the URL and sends only what you have that the
> URL doesn't have.  But you have to be running 2.1.4 on both ends.

In one way, it doesn't make sense to "bk send" a CSET that is already
in the parent repository, so by default <url> should probably be the
parent.  The "proper" mode of operation would be to "bk pull" on the
other end if they want to get a copy of the whole repository, I think.

If you can't contact the repository to check, "bk send" would only send
a subset of CSETs unless told otherwise.  Maybe at most all CSETs generated
locally which do not have CSETs from the parent repository following them,
or maybe non-local CSETs following them.

Unfortunately, I don't know how hard it is to determine "CSETs from the
parent repository".  It is also hard to guess what to do when you _are_
the parent repository.

In general I don't think you ever want to send a whole repository by
email, and this is probably a user error.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

