Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273613AbRIQN2x>; Mon, 17 Sep 2001 09:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273614AbRIQN2n>; Mon, 17 Sep 2001 09:28:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63761 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273613AbRIQN2b>; Mon, 17 Sep 2001 09:28:31 -0400
Date: Mon, 17 Sep 2001 15:28:55 +0200
From: Jan Kara <jack@suse.cz>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4, 2.4-ac and quotas
Message-ID: <20010917152855.B18298@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010917145629.A18298@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0109171401490.20292-100000@nick.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0109171401490.20292-100000@nick.dcs.qmul.ac.uk>; from matt@theBachChoir.org.uk on Mon, Sep 17, 2001 at 02:15:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> >> I'm desperately looking for some recent documentation on quotas.
> >>
> >> We've recently upgraded our two Debian potato fileservers to 2.4 and
> >> 2.4-ac (currently they're both running 2.4-ac so I can't check 2.4 atm)
> >> and quotas have stopped working.
> 
> >  Before you can use new quota you have to convert old quotafiles to new
> >ones. You can do this by convertquota(8) utility which is in the package.
> >Or you can just run 'quotacheck -F vfsv0 -c <mountpoint>' to create completely
> >new quota files with new quota format.
> 
> Thanks--over the weekend I appear to have that bit working. I still can't
> add quotas to my shiny new ext3 partition though :(
> 
> $ touch /export01/aquota.user
> $ umount /export01
> $ mount /export01 -o usrquota
> $ quotaon /export01
> quotaon: using /export01/aquota.user on /dev/sda3: Invalid argument
> 
> The strace shows:
> quotactl(0x10000, 0x8053fe8, 0, 0x8053fc8) = -1 EINVAL (Invalid argument)
> 
> Is there a recent HOWTO on this (maybe I've got it wrong)?
  And are you sure that /export01/aquota.user is correct quotafile (ie.
created by quotacheck or convertquota)? This is message you usually get
when quotafile has incorrect header... (or also when bogus arguments
are specified but it's probably not your case).

								Honza
