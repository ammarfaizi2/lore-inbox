Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWBZRCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWBZRCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWBZRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:02:00 -0500
Received: from mail.linicks.net ([217.204.244.146]:63360 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750886AbWBZRB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:01:59 -0500
From: Nick Warne <nick@linicks.net>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Date: Sun, 26 Feb 2006 17:01:53 +0000
User-Agent: KMail/1.9.1
Cc: "Mark Lord" <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <200602261308.47513.nick@linicks.net> <4401B689.5050106@rtr.ca> <9a8748490602260615i8b72ae4ta3c6b13b568ca45d@mail.gmail.com>
In-Reply-To: <9a8748490602260615i8b72ae4ta3c6b13b568ca45d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261701.53375.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 14:15, Jesper Juhl wrote:
> On 2/26/06, Mark Lord <lkml@rtr.ca> wrote:
> > Nick Warne wrote:

> > > I dunno what happened to the drive that time (this is the only logs of
> > > the incident) and I turned DMA back on with hdparm - but my question is
> > > why is DMA turned off and then left off after a reset?
> >
> > When I wrote that code in the mid-1990s, the number one causes of drives
> > getting confused (and needing to be reset again), were improper DMA
> > timings, cablings, and buggy DMA firmware.
> >
> > So at the time, since DMA was a newish feature for IDE, we figured that
> > turning it off after reset was a Good Thing(tm).
> >
> > And it was.  A more modern implementation might try being more clever
> > about such stuff, and Tejun is working on something like that for libata.

OK, I see...


> > In the meanwhile, you could have a shell script just loop in the
> > background, turning DMA back on periodically.  If you care.

I don't like - anyway, it's the first time I have ever seen this on that box 
in 4 years, it was a quirk somewhere I think (maybe a power fluctuation or 
the like).


> Or how about an option for the IDE driver to "not do that" that people
> could enable if needed/wanted?
> Or just change the code to "not do that" since we are no longer in the
> mid-1990s?

Good idea!

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
