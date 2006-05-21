Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWEUSgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWEUSgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWEUSgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:36:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13970 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932422AbWEUSgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:36:09 -0400
Date: Sun, 21 May 2006 20:35:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Harald Welte <laforge@gnumonks.org>
Cc: Florent Thiery <Florent.Thiery@int-evry.fr>,
       openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060521183521.GD20580@elf.ucw.cz>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <446C5780.7050608@int-evry.fr> <20060518143824.GC17897@sunbeam.de.gnumonks.org> <20060518231613.GA19731@elf.ucw.cz> <20060518232737.GL17897@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518232737.GL17897@sunbeam.de.gnumonks.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > > Another one: you say you're workin on building X-e. Are you talking about kdrive?
> > > 
> > > I have no idea, just replaying the package names that OE uses ;)
> > > 
> > > I now have Xfbdev running on the A780.  Unfortunately due to some
> > > strange black magic, the ts driver ceases to receive interrupts as soon
> > > as X is started. reproducible.  The same happens with ts_test.
> > 
> > Just poll the touchscreen, then... I have similar problems with
> > battery hardware and touchscreen sharing ADCs on collie... but
> > hopefully Motorola did not do _that_ mistake.
> 
> oh yes, the ADC is multiplexed with dozens (well, actually 14)  inputs.
> But you can actually very carefully prorgram which ones to read into
> what register, and have you notified once completed.
> 
> Oh, and to make it even better: The ADC is used by two processors, by
> the Application Processor (that runs linux) and the Baseband Processor
> ;)
> 
> I've now fixed that interrupt problem, but I have some other issues in
> the state machine that is required for alternating pressure/xy reads.
> 
> Confident that those things can be fixed, though.

Okay, looks like collie is clean&simple hardware compared to
*that*. Asymetric MultiProcessing cellphone...

Is there any work going on on higher levels of stack? gomunicator for
user interface... Something for multiplexing AT commands?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
