Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTC0EAi>; Wed, 26 Mar 2003 23:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTC0EAi>; Wed, 26 Mar 2003 23:00:38 -0500
Received: from dp.samba.org ([66.70.73.150]:55489 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262796AbTC0EAe>;
	Wed, 26 Mar 2003 23:00:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sf.net, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Module load notification take 3 
In-reply-to: Your message of "Tue, 25 Mar 2003 11:41:52 -0000."
             <20030325114152.GB30581@compsoc.man.ac.uk> 
Date: Thu, 27 Mar 2003 13:20:23 +1100
Message-Id: <20030327041148.0A4A12C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030325114152.GB30581@compsoc.man.ac.uk> you write:
> On Tue, Mar 25, 2003 at 05:32:33PM +1100, Rusty Russell wrote:
> 
> > > Implement a module load notifier for the benefit of OProfile, tested
> > > with .66 on UP.
> > 
> > Minor change to make unregister_module_notifier return void.
> 
> The -ENOENT return is there for a reason.

What reason?  I just grepped 2.5.66-bk2, and *noone* uses the return
value, not even to BUG() (you have to grep for all the wrappers for
notifier_call_unregister, too).

That's because everyone realizes that the return value is useless.

> If you don't want it, then you should remove it from
> notifier_call_register too.

(I assume you mean notifier_call_unregister).  Yes, but that's another
battle.

Meanwhile, at least I'm not adding to the problem.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
