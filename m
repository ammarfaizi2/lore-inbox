Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUAGXn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUAGXn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:43:58 -0500
Received: from [193.138.115.2] ([193.138.115.2]:24071 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264315AbUAGXnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:43:51 -0500
Date: Thu, 8 Jan 2004 00:40:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <20040107211134.GR1882@matchmail.com>
Message-ID: <Pine.LNX.4.56.0401080032570.9700@jju_lnx.backbone.dif.dk>
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it>
 <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com>
 <3FFC7469.3050700@sun.com> <20040107211134.GR1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Mike Fedyk wrote:

> On Wed, Jan 07, 2004 at 04:04:41PM -0500, Mike Waychison wrote:
> > H. Peter Anvin wrote:
> >
> > >>Also when /home or other important fs are mounted via autofs there is
> > >>not much practical difference between a hung kernel and a hung
> > >>daemon. You have to reboot the system anyways.
> > >
> > >
> > >a) Guess which one is easier to debug?
> >
> > When they may both equally hang your machine, neither.
>
> Let's see.
>
> If it's in userspace, then setup your debug area in an area your system
> doesn't depend on, and wham, the hang won't affect the entire system anymore.
>
> Also, if you have /home automounted then it only affects the users on /home,
> and root's $home should be /home...
>

>From a user point of view I have to agree with you. Keeping it out of the
kernel makes perfect sense to me.

Easier to test your setup - errors will not hang the box.

In the case the implementation is buggy a daemon can easily be restarted
nightly without disrupting other things running on the box (a nightly
reboot is not as friendly).


>From a developer point of view, I also agree.

Debugging kernel code is in general a much harder thing to do than
debugging a userspace daemon. I'd also guess that more people will be
inclined to contribute development time to a userspace program than a
kernel based implementation - just the fact that it's in-kernel will be
percieved as having a much higher barrier-to-entry and I suspect that fact
alone might discourage potential contributers.


- Jesper Juhl

