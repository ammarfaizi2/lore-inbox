Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVEPMvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVEPMvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVEPMvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:51:14 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:21229 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261588AbVEPMvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:51:07 -0400
Subject: Re: Automatic .config generation
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Scott Robert Ladd <lkml@coyotegulch.com>,
       jmerkey <jmerkey@utah-nac.org>, Edgar Toernig <froese@gmx.de>,
       Borislav Petkov <petkov@uni-muenster.de>,
       Jesper Juhl <juhl-lkml@dif.dk>
In-Reply-To: <200505151113.j4FBDf2a011875@turing-police.cc.vt.edu>
References: <200505150742.j4F7gds1020180@turing-police.cc.vt.edu>
	 <Pine.LNX.4.62.0505151148220.2387@dragon.hyggekrogen.localhost>
	 <200505151113.j4FBDf2a011875@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 16 May 2005 08:50:21 -0400
Message-Id: <1116247821.4212.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, check out
http://www.kihontech.com/code/streamline_config.pl :-)


On Sun, 2005-05-15 at 07:13 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 15 May 2005 11:52:51 +0200, Jesper Juhl said:
> > What's the big gain? Where's the harm in just building all the sound
> > modules - you only load one in the end anyway, and the space taken by the
> > other modules is negligible with the disk sizes of today I'd say (ok,
> > there's some extra build time involved, but that shouldn't be a big deal
> 
> If you're doing building and testing on an older/slower box, the build
> time and disk size matters - there's 481 'y' or 'm' in my current .config, versus
> 1701 in the Fedora -1287 kernel.  Being able to do 3 build/reboot loops in
> an hour versus one every 90 mins makes a big difference.  Being able to do a
> build in 400M instead of 2G means that a 7G /usr/src/ partition can hold 8 or 9
> trees, rather than 3 (useful for those "when did this start" regressions, especially
> in combo with that 20 min versus 90 build time. ;)
> 

I have to do a bit of traveling, and one time I didn't want to bring my
main laptop, and instead brought along my 75MHz IBM Thinkpad 755CX. (a
professor laughed at me and jokingly offered me his palm pilot as an
upgrade!).  I actually used this to do kernel compiles. So this can take
quite some time on this type of hardware.

> > you want. Besides, it's not as if you have to redo your kernel config from
> > scratch every time you want a new kernel. Make your favorite config once, 
> > build and install that kernel and then when you want a newer kernel simply 
> > either cd linux-<version>; zcat /proc/config.gz > .config ; make oldconfig 
> > and then build the new kernel using your previous config.
> 
> Yes, that's easy if you're working on *the same hardware*, so new device drivers
> aren't of interest, and the only thing 'make oldconfig' will prompt you for is
> new non-driver functionality. However, that's not everybody...
> 
> The function is for building streamlined configs for new systems - you get
> in a Frobozz2005 laptop, and although you probably have your own favorite set
> of values for things like which netfilter modules to build, you probably have
> *no* idea right off what device drivers you need. So you end up either going
> the RedHat route and building it *all* anyhow, or spending a lot of time
> figuring out which drivers you need for *this* box.  And you can't even trust
> the vendor sometimes - the Dell laptop I'm typing on was part of a larger order.
> A co-worker got another C840, and we had both ordered the same CD/RW-DVD drive.
> Machines had consecutive Dell service/serial numbers - and different vendor
> drives (mine had a Toshiba, his had something else).
> 

With this simple script, you only need to use what the distribution
installed (hopefully it also installs the .config that is used). And the
script will remove all the modules but the ones that are loaded.

-- Steve


