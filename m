Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVLFVz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVLFVz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVLFVz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:55:59 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:50078 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1030267AbVLFVz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:55:58 -0500
Date: Tue, 6 Dec 2005 22:56:10 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Michael Krufky <mkrufky@gmail.com>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Message-ID: <20051206215610.GA18247@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Prakash Punnoor <prakash@punnoor.de>,
	Michael Krufky <mkrufky@gmail.com>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <200512062053.00711.prakash@punnoor.de> <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com> <200512062139.16846.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512062139.16846.prakash@punnoor.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.196.218
Subject: Re: [linux-dvb-maintainer] Re: [PATCH] b2c2: make front-ends selectable and include noob option
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005, Prakash Punnoor wrote:
> Am Dienstag Dezember 6 2005 21:20 schrieb Michael Krufky:
> > On 12/6/05, Prakash Punnoor <prakash@punnoor.de> wrote:
> > > this patch probably needs some touch-up but mainly I am sking the dvb
> > > guys why
> > > don't they do something like this. Current situation:
> >
> > NACK.
> >
> > You are going to run into some problems with this patch... For instance,
> > What if the user chooses to compile the b2c2-flexcop driver in-kernel, but
> > only compiles the frontend drivers as modules...  Then, the frontend
> > support will be built into the flexcop driver, but the module will not yet
> > be available at the time when the kernel is looking for it...
> 
> Well, I said it needed touch up. ;-) After all I didn't seriously believe it 
> gets merged in current state (and yes, I didn't think about the module issue, 
> but you're right , of course). But it simply didn't seem like dvb guys are 
> caring about the problem. I once (probably half a year ago already) mailed to 
> linux-dvb and got zero response. That told me everything.

I make it a point to ignore postings which ignore
the recent mailing list history ;-)

This had been discussed on linux-dvb and the consensus was that
no one wants to invest time to maintain an #ifdef mess
just so that people can save a few KB in their kernel.

Also, most users don't know and don't care what demodulator
their card has, the dependency on all of them, plus the
implied auto probing saves them some headaches and us a lot of
newbie questions.

> Personally I won't invest more time in perfecting the patch. I just wanted to 
> get some attention to this problem and will use the patch privately for my 
> own happiness...

The b2c2-flexcop-pci driver could certainly use some fixing. Your
patch just hides the driver problems by deselecting functionality
that _you_ don't need.


Johannes
