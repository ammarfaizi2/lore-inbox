Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUADLZM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUADLZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:25:11 -0500
Received: from mail.mediaways.net ([193.189.224.113]:31904 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S265384AbUADLZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:25:06 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: azarah@nosferatu.za.org
Cc: Con Kolivas <kernel@kolivas.org>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <1073214820.6075.254.camel@nosferatu.lan>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401041242.47410.kernel@kolivas.org>
	 <1073203762.9851.394.camel@localhost>
	 <200401041949.27408.kernel@kolivas.org>
	 <1073214820.6075.254.camel@nosferatu.lan>
Content-Type: text/plain
Message-Id: <1073215450.3239.22.camel@localhost>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 12:24:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 12:13, Martin Schlemmer wrote:
> On Sun, 2004-01-04 at 10:49, Con Kolivas wrote:
> 
> > > I added a fprintf(stderr, "%d\n", amount); to that code and indeed
> > > amount was *always* 1 no matter what I did (it even was 1 when the
> > > (dmesg/...) output came in fast). And jump scrolling would take place if
> > > amount > 59 in my case... can this still be not a schedulers issue ?
> > >
> > 
> > > Looking at that how can it not be a scheduling problem ....
> > 
> > Scheduling problem, yes; of a sort.
> > 
> > Solution by altering the scheduler, no. 
> > 
> > My guess is that turning the xterm graphic candy up or down will change the 
> > balance. Trying to be both gui intensive and a console is where it's 
> > happening. On some hardware you are falling on both sides of the fence with 
> > 2.6 where previously you would be on one side.
> > 
> 
> So its Ok for 'eye candy' to 'lag', but xmms should not skip?  Anyhow,
> its xterm that he have issues with, not gnome-terminal or such with
> transparency.  I smell something ...

I would not call it 'lag' if an ls of /usr/bin takes 20 secs vs 1 sec
before... I mean the scroll speed limits e.g. the compile speed...

Well I now tried xterm, gnome-terminal (gtk2), multi-gnome-terminal
(gtk1), xvt, aterm, wterm, Eterm, and yes they are all (except for
Eterm) plain text on solid background - so no eye candy. Interestingly
Eterm, wterm and aterm seem to not be affected by that issue.

Soeren

