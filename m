Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTETMI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTETMI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:08:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:641 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263743AbTETMI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:08:58 -0400
Date: Tue, 20 May 2003 08:23:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Robert White <rwhite@casabyte.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <3ECA189A.30300@aitel.hist.no>
Message-ID: <Pine.LNX.4.53.0305200809060.3996@chaos>
References: <PEEPIDHAKMCGHDBJLHKGGEENCMAA.rwhite@casabyte.com>
 <3ECA189A.30300@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 May 2003, Helge Hafting wrote:

> Robert White wrote:
> > Er..
> >
> > The gnome wields a morality stick, the morality stick wields itself to the
> > gnome's hand...
> > ---more---
> > The gnome hits you... you feel better...
> >
> >
> > Your "moral position"...
> >
> > (quote) I want them to either learn to comprehend locking _properly_, or
> > take up gardening instead. (unquote)
> >
> > ...is critically flawed.
> >
> > In point of fact, "proper" locking, when combined with "proper" definitions
> > of an interface dictate that recursive locking is "better".  Demanding that
> > a call_EE_ know what locks a call_ER_ (and all antecedents of caller) will
> > have taken is not exactly good design.
>
> That depends on how big the total system is.  You can break things
> down into independent modules and submodules that don't know each other, but
> at some point people need to know a whole module to do it properly.
>
[SNIPPED...]

Recursive locking is a misnomer. It does during run-time that which
should have been done during design-time. In fact, there cannot
be any recursion associated with locking. A locking mechanism that
allows reentry or recursion is defective, both in design, and
implementation.

The nature of a lock is required to be such that if the locked object
is in use, no access to that object is allowed. Recursive locking
implies that if the lock is in use by the same thread that locked
it before, then access to that object is allowed. In other words,
if the coder (as opposed to designer) screwed up, the locking
mechanism will allow it. If this is the way students are being
taught to write code at the present time, all software will
be moved off-shore in the not too distant future. There is
absolutely no possible justification for such garbage. Just
because some idiot wrote an article and got it published,
doesn't mean this diatribe has any value at all.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

