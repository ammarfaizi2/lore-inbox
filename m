Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWJFJWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWJFJWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWJFJWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:22:25 -0400
Received: from twin.jikos.cz ([213.151.79.26]:23724 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751353AbWJFJWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:22:24 -0400
Date: Fri, 6 Oct 2006 11:22:17 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-git21, possible recursive locking in kseriod ends up in
 DWARF2 unwinder stuck
In-Reply-To: <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610061119240.12556@twin.jikos.cz>
References: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com> 
 <Pine.LNX.4.64.0610042317590.12556@twin.jikos.cz>
 <d120d5000610051334o7604b1d4hd2f4c9a9b858f06e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Dmitry Torokhov wrote:

> I tested the patches and they work. Couple of comments:
> - register_lock_class is marked as inline but now has 2 call sites and
> is relatively big - might want to remove "inline"

I agree.

> - how about adding lockdep_set_subclass() to avoid littering source
> with struct lock_class_key when we only want to tweak subclass? For
> that we might want export register_lock_class and hide it behind a
> #define...

I added Ingo to CC so that he could comment.

However I would not be able to submit patches which will be tested, as the 
only machine I had with passthrough synpatics port broke horribly and is 
currently in the warranty repair.

-- 
Jiri Kosina
