Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266647AbUGKSID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbUGKSID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 14:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUGKSID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 14:08:03 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22969 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266647AbUGKSH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 14:07:59 -0400
Date: Sun, 11 Jul 2004 20:07:59 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
In-Reply-To: <20040711041329.22f637d1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407112004570.695@artax.karlin.mff.cuni.cz>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org>
 <20040711093209.GA17095@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org>
 <20040711095039.GA22391@elte.hu> <20040711025855.08afbca1.akpm@osdl.org>
 <20040711103020.GA24797@elte.hu> <20040711034258.796f8c6a.akpm@osdl.org>
 <20040711105936.GA13956@devserv.devel.redhat.com> <20040711041329.22f637d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jul 2004, Andrew Morton wrote:

> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > On Sun, Jul 11, 2004 at 03:42:58AM -0700, Andrew Morton wrote:
> > > > We do not want to enable preempt for Fedora yet because it
> > > > breaks just too much stuff
> > >
> > > What stuff?
> >
> > just look over all the "fix preempt" stuff that got added to the kernel in
> > the last 6 months. Sometimes subtle sometimes less so. From a distribution
> > POV I don't want a potential slew of basically impossible to reproduce
> > problems, especially this young in 2.6, there are plenty of other problems
> > already (and before you ask "which", just look at how many bugs got fixed in
> > the last X weeks for any value of X, and look at say acpi issues).
> > Yes I understand this puts you into a bit of a bad position, several distros
> > not enabling preempt means that it gets less testing than it should.
> > However.. there's only so much issues distros can take and with 2.6 still
> > quite fresh...
> >
>
> IOW: "we haven't found any such stuff".  Sounds fuddy to me.

For example the recent race that corrupted file content on ext3 and
reiserfs when fsync and write were called simultaneously ... it was
possible on SMP too, but with tiny probability --- CONFIG_PREEMPT
triggered it wide open.

Mikulas
