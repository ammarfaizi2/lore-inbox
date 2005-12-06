Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVLFWUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVLFWUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVLFWUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:20:05 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:36466 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932646AbVLFWUB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:20:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJuRrxI2WtqUFb+7ICp7ZMXoOo1beLtKNprfgeM9IAcyQDTU0g8eBBgqM1fx71dJIzVmFW26kST6u3qNN0+pgOHN5K+bYSECTzGGfOUZJVLAp0F2BI7Rw91+R6NfL3vE5AkJlAqnon9tk0YYzv5gZFxjSS1RlhA7cndK9qAmX1M=
Message-ID: <37219a840512061420j6dc6a0bdy71cc817706dcd0ef@mail.gmail.com>
Date: Tue, 6 Dec 2005 17:20:00 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Johannes Stezenbach <js@linuxtv.org>, Prakash Punnoor <prakash@punnoor.de>,
       Michael Krufky <mkrufky@gmail.com>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] Re: [PATCH] b2c2: make front-ends selectable and include noob option
In-Reply-To: <20051206215610.GA18247@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512062053.00711.prakash@punnoor.de>
	 <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com>
	 <200512062139.16846.prakash@punnoor.de>
	 <20051206215610.GA18247@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> On Tue, Dec 06, 2005, Prakash Punnoor wrote:
> > Am Dienstag Dezember 6 2005 21:20 schrieb Michael Krufky:
> > > On 12/6/05, Prakash Punnoor <prakash@punnoor.de> wrote:
> > > > this patch probably needs some touch-up but mainly I am sking the dvb
> > > > guys why
> > > > don't they do something like this. Current situation:
> > >
> > > NACK.
> > >
> > > You are going to run into some problems with this patch... For instance,
> > > What if the user chooses to compile the b2c2-flexcop driver in-kernel, but
> > > only compiles the frontend drivers as modules...  Then, the frontend
> > > support will be built into the flexcop driver, but the module will not yet
> > > be available at the time when the kernel is looking for it...
> >
> > Well, I said it needed touch up. ;-) After all I didn't seriously believe it
> > gets merged in current state (and yes, I didn't think about the module issue,
> > but you're right , of course). But it simply didn't seem like dvb guys are
> > caring about the problem. I once (probably half a year ago already) mailed to
> > linux-dvb and got zero response. That told me everything.
>
> I make it a point to ignore postings which ignore
> the recent mailing list history ;-)
>
> This had been discussed on linux-dvb and the consensus was that
> no one wants to invest time to maintain an #ifdef mess
> just so that people can save a few KB in their kernel.
>
> Also, most users don't know and don't care what demodulator
> their card has, the dependency on all of them, plus the
> implied auto probing saves them some headaches and us a lot of
> newbie questions.
>
> > Personally I won't invest more time in perfecting the patch. I just wanted to
> > get some attention to this problem and will use the patch privately for my
> > own happiness...
>
> The b2c2-flexcop-pci driver could certainly use some fixing. Your
> patch just hides the driver problems by deselecting functionality
> that _you_ don't need.
>

Johannes -

If you approve of the method that I used to implement compile-time
frontend selection in cx88-dvb and saa7134-dvb, then I would be happy
to implement this into the flexcop driver as well.  I understand why
developers might not want to invest the time into this, but I see the
benefits to it, and I am willing to work on it.  Of course, this
wouldnt be sent to the kernel until 2.6.16 (or maybe 2.6.17)

I have the bcm3510-based board in my possesion right now, and both the
nxt2002 and lgdt3303 versions are in the mail to me as I type this
email.  (I plan to use the nxt2002 version to test and fix the nxt200x
driver for this use.)

OTOH, if there are other reasons to stay away from this idea, say the
word, and I'll send a revert patch to Andrew for the cx88 and saa7134
stuff...  It is working well -- Gene reported a bug and I fixed it,
already in Linus' tree.

What do you think?

-Michael
