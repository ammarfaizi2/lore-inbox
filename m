Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSHRVtz>; Sun, 18 Aug 2002 17:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSHRVtz>; Sun, 18 Aug 2002 17:49:55 -0400
Received: from ip68-4-77-172.oc.oc.cox.net ([68.4.77.172]:47609 "HELO
	ip68-4-77-172.oc.oc.cox.net") by vger.kernel.org with SMTP
	id <S316430AbSHRVty>; Sun, 18 Aug 2002 17:49:54 -0400
Date: Sun, 18 Aug 2002 14:53:55 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
Message-ID: <20020818215355.GB5154@ip68-4-77-172.oc.oc.cox.net>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu> <1029662182.2970.23.camel@psuedomode> <1029694235.520.9.camel@psuedomode> <6un0rkuiyg.fsf@zork.zork.net> <1029695363.1357.5.camel@psuedomode> <6uhehsui80.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uhehsui80.fsf@zork.zork.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 07:36:47PM +0100, Sean Neakums wrote:
> commence  Ed Sweetman quotation:
[snip]
> > the devfs documentation says it doesn't need to have devfs mounted
> > to work, but this doesn't seem to be true at all.
> 
> If it does say exactly that, then it is outrageously wrong.

Starting at line 722 of
linux-2.4.19/Documentation/filesystems/devfs/README:

> In general, a kernel built with CONFIG_DEVFS_FS=y but without mounting
> devfs onto /dev is completely safe, and requires no
> configuration changes.

I skimmed through the documentation and it appears to assume that you're
not deleting all the stuff in /dev before switching over to devfs.

> > Hence my confusion. I know i can go download a bootable iso and get
> > that burned and working but I shouldn't have to do that.
> 
> Uh, you deleted your devices nodes, and now you want to boot the
> system without devfs.  You have to do precisely that, or something
> equivalent.

Right, there's no way around that. If you deleted everything in /dev --
which you're not supposed to do -- then there's no way for anything to
find any devices if devfs isn't enabled. (And you should have a rescue
CD around anyway -- you never know when you might need it! BTW, what
distribution are you (Ed) using? Some distributions have special boot
options you can use when booting their install CDs to get into a rescue
mode.)

In any event, it might be a good idea to make the documentation a bit
more explicit about this, and I might send a patch to the mailing
list later today.

-Barry K. Nathan <barryn@pobox.com>
