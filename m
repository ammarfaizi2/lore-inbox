Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274175AbRISU3z>; Wed, 19 Sep 2001 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274171AbRISU3f>; Wed, 19 Sep 2001 16:29:35 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:41467 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274167AbRISU32>; Wed, 19 Sep 2001 16:29:28 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 14:29:04 -0600
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: Fabian Arias <dewback@vtr.net>, LKML <linux-kernel@vger.kernel.org>,
        reiserfs-list@namesys.com
Subject: Re: 2.4.9-ac12 - problem mounting reiserfs (parse error?)
Message-ID: <20010919142904.P14526@turbolinux.com>
Mail-Followup-To: Wayne Whitney <whitney@math.berkeley.edu>,
	Fabian Arias <dewback@vtr.net>, LKML <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com
In-Reply-To: <20010919132935.M14526@turbolinux.com> <Pine.LNX.4.33.0109191304190.16915-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109191304190.16915-100000@mf1.private>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2001  13:14 -0700, Wayne Whitney wrote:
> On Wed, 19 Sep 2001, Andreas Dilger wrote:
> > Could you run gdb on your mount and show us what *data contains at
> > this point (last parameter).  According to man(8) "defaults" expands
> > to "rw,suid,dev,exec,auto,nouser,async".
> 
> Hmm, I'm not versant with gdb (strace is the extent of my sophistication),
> so I'll try your suggestion below.
> 
> > You could also try putting all of these in /etc/fstab explicitly and
> > remove them one at a time until we find which one it is complaining
> > about.  Either mount(8) shouldn't be appending this option to the
> > mount data, or reiserfs needs to parse it in the kernel.
> 
> It seems that the reiserfs option parsing in 2.4.9-ac12 is foobar, as any
> one of "rw,suid,dev,exec,auto,nouser,async" in the options field in
> /etc/fstab causes the mount to fail.  Also, mounting an r5-hashed reiserfs
> file system with the option string "hash=r5" gives this fine error:
> 
> REISERFS: Error, r5 hash detected, unable to force r5 hash
> 
> I can confirm that the following option strings give a successful mount:
> "conv", "hashed_relocation", "notail".  I didn't feel like going through
> all the options possible.

I have CC'd this to reiserfs-list so they know about it.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

