Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318970AbSIIWwt>; Mon, 9 Sep 2002 18:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSIIWwt>; Mon, 9 Sep 2002 18:52:49 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:1959 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318970AbSIIWws>; Mon, 9 Sep 2002 18:52:48 -0400
Date: Mon, 9 Sep 2002 23:56:54 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020909235654.A5875@kushida.apsleyroad.org>
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship> <20020909204834.A5243@kushida.apsleyroad.org> <E17oUtY-0006tn-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17oUtY-0006tn-00@starship>; from phillips@arcor.de on Mon, Sep 09, 2002 at 10:12:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> > The expected behaviour is as it has always been: rmmod fails if anyone
> > is using the module, and succeeds if nobody is using the module.  The
> > garbage collection of modules is done using "rmmod -a" periodically, as
> > it always has been.
> 
> When you say 'rmmod modulename' the module is supposed to be removed, if
> it can be.  That is the user's expectation, and qualifies as 'obviously
> correct'.
> 
> Garbage collecting should *not* be the primary mechanism for removing
> modules, that is what rmmod is for.  Neither should a filesystem module
> magically disappear from the system just because the last mount went
> away, unless the module writer very specifically desires that.  This is
> where the obfuscating opinion is coming from: Al has come up with an
> application where he wants the magic disappearing behavior and wants
> to impose it on the rest of the world, regardless of whether it makes
> sense.

I think you've misunderstood.  The module does _not_ disappear when the
last file reference is closed.  It's reference count is decremented,
that is all.  Just the same as if you managed the reference count
yourself.  You still need rmmod to actually remove the module.

-- Jamie
