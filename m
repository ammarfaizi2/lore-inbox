Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318024AbSGRMJL>; Thu, 18 Jul 2002 08:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSGRMJL>; Thu, 18 Jul 2002 08:09:11 -0400
Received: from dsl-213-023-043-252.arcor-ip.net ([213.23.43.252]:45255 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318024AbSGRMJK>;
	Thu, 18 Jul 2002 08:09:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] new module format
Date: Thu, 18 Jul 2002 14:13:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207181350020.8911-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0207181350020.8911-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17VAA4-0004o6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 14:02, Roman Zippel wrote:
> Hi,
> 
> On Thu, 18 Jul 2002, Daniel Phillips wrote:
> 
> > To add a new user, the active bit has to be set, as shown in this skeleton,
> > which is pretty much the existing try_inc_mod_count scheme:
> >
> >        spin_lock(&some_spinlock);
> >        if (<mod_active_bit>)
> >                <inc_mod_user_count>
> >        spin_unlock(&some_spinlock);
> >
> >        if <users>, do the mount
> >
> > In other words, the module has some state, the transitions of which are
> > protected by a spinlock.
> 
> This means you still need another lock to protect the data structures and
> you still have module pointers everywhere.

A module pointer per filesystem does not count as 'everywhere'.

> I want to get rid of that
> "same_spinlock" (aka unload_lock), because it's not needed.
> I suggest we continue this discussion when I post the new patches in a few
> days, then it should become more clear.

Sure.

-- 
Daniel
