Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSHGXU0>; Wed, 7 Aug 2002 19:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSHGXU0>; Wed, 7 Aug 2002 19:20:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47632 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316491AbSHGXUZ>; Wed, 7 Aug 2002 19:20:25 -0400
Date: Wed, 7 Aug 2002 19:04:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       nick.orlov@mail.ru
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <1528932608D@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.96.1020807184958.14463D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Petr Vandrovec wrote:

> On  7 Aug 02 at 0:54, Adam J. Richter wrote:

> >     Linux users in the "I'm not a sysadmin" crowd (?) probably
> > don't care about the scan order of the pdc20265 IDE controller,
> > but people in the "I'm a sysadmin, not a programmer" crowd
> > may have legitimiate reasons to.
> 
> But such "I'm not a sysadmin" people will be very surprised that their
> promise was IDE2 in 2.2.x, it was IDE2 in 2.4.18, it is IDE2 in 2.5.30,
> and now - oops - it is IDE0 in 2.4.19. Broken, I'd say.

And on that one I really do agree. A change like that in 2.5 wouldn't
bother me beyond usual ten minutes of consigning whoever did it to the
darkest level of hell ;-) I would think that distributions would ship with
a kernel which follows Plauger's "law of least astonishment," so it may
not matter unless you roll your own. Kind of violates the idea of "stable"
IMHO, but I have other design decisions which bother me far more.
 
> There is an CONFIG_BLK_DEV_OFFBOARD option (apparently unused...),
> so use this one, if some distribution must force ide0= to promise 
> if their installer cannot find master disk on /dev/hde. But changing
> behavior for no reason - especially in the middle of stable series -
> is IMHO unacceptable. 

I disagree with "no reason," there was a reason, but I do think it was a
bad idea. There just aren't that many people with an onboard controller to
justify a change. My opinion, of course.
 
> Fortunately I use 2.5.30's IDE for real work ;-)

I use 2.5 kernels to test my backups :-( The last one I ran drooled
spillage in every attached drive, including my BSD drive which is on an
offboard controller. I would tell you the version, but it gone. Somewhere
in the 2.5.24..27 range.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

