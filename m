Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSEVT47>; Wed, 22 May 2002 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316718AbSEVT46>; Wed, 22 May 2002 15:56:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56330 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316715AbSEVT45>; Wed, 22 May 2002 15:56:57 -0400
Date: Wed, 22 May 2002 21:57:00 +0200
From: Jan Kara <jack@suse.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Jan Kara <jack@suse.cz>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>
Subject: Re: Quota patches
Message-ID: <20020522195700.GA3595@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020520135530.GB9209@atrey.karlin.mff.cuni.cz> <87bsb86k4r.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
  
> Jan Kara <jack@suse.cz> writes:
> 
> >   Hello,
> > 
> >   In following mails I'll send (because patches are big, I'll post them just
> > diretly to Linus - others see ftp below) quota patches for 2.5.15 (patches
> > apply well on 2.5.16 too). Currently they implement:
> >   * new quota format (allows 32 uids, accounting in bytes -> mainly for
> >     Reiserfs)
> >   * needed infrastructure for XFS quota
> >   * quota statistics in /proc (we can drop Q_GETSTATS call; it's a lot
> >     easier to change in future)
> >   * implements correct syncing of quota
> >   * introduces interface which allows usage of both quota formats in kernel
> >   * implemented filesystem callback function on certain quota operations
> >     (needed for journaled quota, Ext3)
> >   * implements ioctl() for reporting occupied space in bytes (not just blocks)
> > 
> >   The patches can be downloaded at:
> > ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.5/2.5.15/
> > 
> >   Old quota tools should work with patches if you configure old quota interface
> > in '.config'. There are also quota utilities capable of communicating with new
> > generic interface. You can download them at:
> > 
> > http://www.sf.net/projects/linuxquota/
> > 
> > or you can checkout version from SourceForge CVS.
> > 
> >   Any comments & bugreports welcome.
> 
> What do you think of the following patches for kernel without
> quota support? We already have weak symbol for sys_quotactl(). 
  I know this but this file is also needed by XFS people so it isn't
so easy.  But as XFS stuff is not currently in kernel the change is
probably for now (I'll check whether there's not some hidden reference
I forgot about and submit patch to Linus).

								Honza
