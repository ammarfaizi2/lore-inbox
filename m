Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTE2OvC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTE2OvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:51:02 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:46271 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262288AbTE2OuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:50:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Fri, 30 May 2003 01:04:11 +1000
User-Agent: KMail/1.5.1
Cc: Elladan <elladan@eskimo.com>, Jens Axboe <axboe@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <200305290903.42996.kernel@kolivas.org> <20030529130933.GI1453@dualathlon.random>
In-Reply-To: <20030529130933.GI1453@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305300104.11370.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 23:09, Andrea Arcangeli wrote:
> On Thu, May 29, 2003 at 09:03:42AM +1000, Con Kolivas wrote:
> > On Thu, 29 May 2003 04:47, Elladan wrote:
> > > On Wed, May 28, 2003 at 02:53:12PM +0200, Jens Axboe wrote:
> > > > On Wed, May 28 2003, Marc-Christian Petersen wrote:
> > > > > On Wednesday 28 May 2003 13:27, Andrew Morton wrote:
> > > > >
> > > > > Hi Akpm,
> > > > >
> > > > > > > Does the attached one make sense?
> > > > > >
> > > > > > Nope.
> > > > >
> > > > > nm.
> > > > >
> > > > > > Guys, you're the ones who can reproduce this.  Please spend more
> > > > > > time working out which chunk (or combination thereof) actually
> > > > > > fixes the problem.  If indeed any of them do.
> > > > >
> > > > > As I said, I will test it this evening. ATM I don't have time to
> > > > > recompile and reboot. This evening I will test extensively, even on
> > > > > SMP, SCSI, IDE and so on.
> > > >
> > > > May I ask how you are reproducing the bad results? I'm trying in vain
> > > > here...
> > >
> > > It might be useful to check what video hardware and X servers people
> > > are using here.  If the behavior is just mouse freezups, the "silken
> > > mouse" feature of XFree might have some effect, since it involves XFree
> > > binding a signal to mouse device events.
> >
> > Xfree 3.3.6, 4.2,4.3
> > Drivers nvidia, nv, sis, sisfb, vesa, vesafb
> >
> > are the drivers on the machines where I've seen it happen so far - ie
> > without discrimination.
>
> what about the window manager? do you use focus follow mouse? Just
> trying to find a pattern. For the record KDE 3.1 + focus follow mouse
> and X 4.3.0 here, I guess Jens uses the same software combination. the
> mouse for me is always perfectly fluid no matter how fast and how long I
> write, no matter if I don't touch the mouse for minutes, ALT+TAB as
> well. I definitely can't reproduce in any way the mouse stalls (I'm
> using cp /dev/zero .  on a ext3 fs in ordered mode). hardware is 1G of
> ram smp IDE single spindle primary master matrox GS450. I almost
> couldn't notice the background write flood if I only would increase the
> xmms buffer (infact I thought it stopped writing for a dozen seconds out
> of space, and instead it was still writing).  (kernel is 2.4.21rc4aa1 of
> course)

Why should it matter what wm I use if the pauses were there before and not 
there now?

Con
