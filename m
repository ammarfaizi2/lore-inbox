Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTBTA0k>; Wed, 19 Feb 2003 19:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTBTAZj>; Wed, 19 Feb 2003 19:25:39 -0500
Received: from dp.samba.org ([66.70.73.150]:62886 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262871AbTBTAZf>;
	Wed, 19 Feb 2003 19:25:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible? 
In-reply-to: Your message of "Wed, 19 Feb 2003 01:11:54 -0300."
             <20030219011154.X2092@almesberger.net> 
Date: Thu, 20 Feb 2003 10:38:50 +1100
Message-Id: <20030220003540.284ED2C489@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030219011154.X2092@almesberger.net> you write:
> Rusty Russell wrote:
> > Of course, if you wanted to remove the entry at any other time
> > (eg. hotplug), this doesn't help you one damn bit (which is kind of
> > your point).
> 
> Yep, try_module_get solves the general synchronization problem for
> the special but interesting case of modules, but not for the general
> case.

Absolutely.  And I admire your (and Roman's) bravery for trying the
general case.

> will have little qualms of letting you sleep "forever". (And,
> naturally, every once in a while, people hate it for this :-)

(Well, MOD_INC_USE_COUNT is already deprecated, mainly because it's
used to try to control module counts from within, which preempt makes
really hard).

Yes, the addition of "umount -l" is congruent to "rmmod --wait".  The
assumption is "I don't want any new users, and I'll handle any current
ones".  You can get yourself in trouble with both of them.

Keep up the good work,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
