Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319696AbSIMQeJ>; Fri, 13 Sep 2002 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319698AbSIMQeJ>; Fri, 13 Sep 2002 12:34:09 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:10478 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319696AbSIMQeI>; Fri, 13 Sep 2002 12:34:08 -0400
Date: Fri, 13 Sep 2002 10:39:08 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17psOu-0008AW-00@starship>
Message-ID: <Pine.LNX.4.44.0209131031480.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Daniel Phillips wrote:
> That's debatable.  Arguably, a failed ->module_cleanup() should be
> retried on every rmmod -a, but expecting module.c to just keep
> retrying mindlessly on its own sounds too much like a busy wait.

Hmmm. You might as well give it back to the user.

rmmod: remove failed: do it again!

So the cleanup code could as well just do it on its own.

> > Why is that sloppy? E.g. kfree() happily accepts NULL pointers as well.
> 
> That is sloppy.  Different discussion.

What should kfree do in your opinion? BUG()?

doodle.c:12: attempted to free NULL pointer, as you know it already is.

> I take it that the points you didn't reply to are points that you
> agree with?  (The main point being, that we both advocate a simple,
> two-method interface for module load/unload.)

You could even do it using three methods.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

