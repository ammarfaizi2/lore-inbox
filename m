Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSHGKUU>; Wed, 7 Aug 2002 06:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317605AbSHGKUU>; Wed, 7 Aug 2002 06:20:20 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:20241 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317593AbSHGKUU>;
	Wed, 7 Aug 2002 06:20:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 7 Aug 2002 12:20:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] pdc20265 problem.
CC: davidsen@tmr.com, linux-kernel@vger.kernel.org, nick.orlov@mail.ru
X-mailer: Pegasus Mail v3.50
Message-ID: <1528932608D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Aug 02 at 0:54, Adam J. Richter wrote:
> Nick Orlov writes:
> >But wouldn't it be a cleaner solution if we will have _compile_ time
> >option that by default is turned on in order to handle rare cases,
> >and _can_ be turned off in order to handle _most_ cases without any
> >boot-time options?
> 
>     Linux users in the "I'm not a sysadmin" crowd (?) probably
> don't care about the scan order of the pdc20265 IDE controller,
> but people in the "I'm a sysadmin, not a programmer" crowd
> may have legitimiate reasons to.

But such "I'm not a sysadmin" people will be very surprised that their
promise was IDE2 in 2.2.x, it was IDE2 in 2.4.18, it is IDE2 in 2.5.30,
and now - oops - it is IDE0 in 2.4.19. Broken, I'd say.

There is an CONFIG_BLK_DEV_OFFBOARD option (apparently unused...),
so use this one, if some distribution must force ide0= to promise 
if their installer cannot find master disk on /dev/hde. But changing
behavior for no reason - especially in the middle of stable series -
is IMHO unacceptable. 

Fortunately I use 2.5.30's IDE for real work ;-)
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
