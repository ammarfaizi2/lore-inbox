Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269092AbTBXCtA>; Sun, 23 Feb 2003 21:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269094AbTBXCs7>; Sun, 23 Feb 2003 21:48:59 -0500
Received: from dp.samba.org ([66.70.73.150]:49098 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269092AbTBXCsz>;
	Sun, 23 Feb 2003 21:48:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add module load profile hook 
In-reply-to: Your message of "Fri, 21 Feb 2003 00:54:12 -0000."
             <20030221005412.GA95016@compsoc.man.ac.uk> 
Date: Mon, 24 Feb 2003 11:33:34 +1100
Message-Id: <20030224025907.A75512C093@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030221005412.GA95016@compsoc.man.ac.uk> you write:
> On Fri, Feb 21, 2003 at 11:33:46AM +1100, Rusty Russell wrote:
> 
> > Sure, but I think I prefer a more generic notifier mechanism anyway,
> > which oprofile can use as well as other mechanisms.
> > 
> > Say, module_notifier with a MODULE_LOADED, MODULE_INITIALIZED,
> > MODULE_UNLOADING, MODULE_GONE?
> 
> What needs this ?

I was thinking those who want to roll their own two-stage init and
delete.  I wouldn't implement them all at first, but putting a
notifier in is simple, and it can be expanded later.

ie. you'd just implement MODULE_INITIALIZED, and leave the rest.

Fair?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
