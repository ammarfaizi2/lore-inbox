Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUADMp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUADMp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:45:59 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:40130
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S265478AbUADMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:45:56 -0500
From: Con Kolivas <kernel@kolivas.org>
To: azarah@nosferatu.za.org
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Date: Sun, 4 Jan 2004 23:45:32 +1100
User-Agent: KMail/1.5.3
Cc: Soeren Sonnenburg <kernel@nn7.de>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401041949.27408.kernel@kolivas.org> <1073214820.6075.254.camel@nosferatu.lan>
In-Reply-To: <1073214820.6075.254.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401042345.33039.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 22:13, Martin Schlemmer wrote:
> On Sun, 2004-01-04 at 10:49, Con Kolivas wrote:
> > > I added a fprintf(stderr, "%d\n", amount); to that code and indeed
> > > amount was *always* 1 no matter what I did (it even was 1 when the
> > > (dmesg/...) output came in fast). And jump scrolling would take place
> > > if amount > 59 in my case... can this still be not a schedulers issue ?
> > >
> > >
> > > Looking at that how can it not be a scheduling problem ....
> >
> > Scheduling problem, yes; of a sort.
> >
> > Solution by altering the scheduler, no.
> >
> > My guess is that turning the xterm graphic candy up or down will change
> > the balance. Trying to be both gui intensive and a console is where it's
> > happening. On some hardware you are falling on both sides of the fence
> > with 2.6 where previously you would be on one side.
>
> So its Ok for 'eye candy' to 'lag', but xmms should not skip?  Anyhow,
> its xterm that he have issues with, not gnome-terminal or such with
> transparency.  I smell something ...

Sigh... 

Xmms was a simple test case long forgotten but most still think all I did was 
make an xmms scheduler. Deleting one character from sched.c before all of my 
patches would make the scheduler ideal for xmms. Any braindead idiot can tune 
a scheduler for just one application. An application that changes it's 
behaviour dynamically well in the setting of a particular scheduler, though? 
Should a scheduler be tuned to suit a coding style or quirk? 

I should go back to lurking before people start calling me names. This thread 
has gone long enough for that. If I hadn't said anything it would have died 
out by now. Instead I'm drawing attention to my fundamentally flawed code.

Con

