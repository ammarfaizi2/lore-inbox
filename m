Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSIIUFg>; Mon, 9 Sep 2002 16:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSIIUFg>; Mon, 9 Sep 2002 16:05:36 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:52160 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318722AbSIIUFe>;
	Mon, 9 Sep 2002 16:05:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Mon, 9 Sep 2002 22:12:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship> <20020909204834.A5243@kushida.apsleyroad.org>
In-Reply-To: <20020909204834.A5243@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oUtY-0006tn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 21:48, Jamie Lokier wrote:
> The expected behaviour is as it has always been: rmmod fails if anyone
> is using the module, and succeeds if nobody is using the module.  The
> garbage collection of modules is done using "rmmod -a" periodically, as
> it always has been.

When you say 'rmmod modulename' the module is supposed to be removed, if
it can be.  That is the user's expectation, and qualifies as 'obviously
correct'.

Garbage collecting should *not* be the primary mechanism for removing
modules, that is what rmmod is for.  Neither should a filesystem module
magically disappear from the system just because the last mount went
away, unless the module writer very specifically desires that.  This is
where the obfuscating opinion is coming from: Al has come up with an
application where he wants the magic disappearing behavior and wants
to impose it on the rest of the world, regardless of whether it makes
sense.

-- 
Daniel
