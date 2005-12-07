Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVLGA3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVLGA3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 19:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbVLGA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 19:29:08 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:57758 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932664AbVLGA3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 19:29:06 -0500
Date: Wed, 7 Dec 2005 01:29:19 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Michael Krufky <mkrufky@gmail.com>
Cc: Prakash Punnoor <prakash@punnoor.de>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Message-ID: <20051207002919.GA18629@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Michael Krufky <mkrufky@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <200512062053.00711.prakash@punnoor.de> <37219a840512061220w17388551jd54c189973e23355@mail.gmail.com> <200512062139.16846.prakash@punnoor.de> <20051206215610.GA18247@linuxtv.org> <37219a840512061420j6dc6a0bdy71cc817706dcd0ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37219a840512061420j6dc6a0bdy71cc817706dcd0ef@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.196.218
Subject: Re: [linux-dvb-maintainer] Re: [PATCH] b2c2: make front-ends selectable and include noob option
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005, Michael Krufky wrote:
> On 12/6/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> > On Tue, Dec 06, 2005, Prakash Punnoor wrote:
> > > Well, I said it needed touch up. ;-) After all I didn't seriously believe it
> > > gets merged in current state (and yes, I didn't think about the module issue,
> > > but you're right , of course). But it simply didn't seem like dvb guys are
> > > caring about the problem. I once (probably half a year ago already) mailed to
> > > linux-dvb and got zero response. That told me everything.
> >
> > I make it a point to ignore postings which ignore
> > the recent mailing list history ;-)
> >
> > This had been discussed on linux-dvb and the consensus was that
> > no one wants to invest time to maintain an #ifdef mess
> > just so that people can save a few KB in their kernel.
> >
> > Also, most users don't know and don't care what demodulator
> > their card has, the dependency on all of them, plus the
> > implied auto probing saves them some headaches and us a lot of
> > newbie questions.
> >
> > > Personally I won't invest more time in perfecting the patch. I just wanted to
> > > get some attention to this problem and will use the patch privately for my
> > > own happiness...
> >
> > The b2c2-flexcop-pci driver could certainly use some fixing. Your
> > patch just hides the driver problems by deselecting functionality
> > that _you_ don't need.
> 
> If you approve of the method that I used to implement compile-time
> frontend selection in cx88-dvb and saa7134-dvb, then I would be happy
> to implement this into the flexcop driver as well.  I understand why
> developers might not want to invest the time into this, but I see the
> benefits to it, and I am willing to work on it.  Of course, this
> wouldnt be sent to the kernel until 2.6.16 (or maybe 2.6.17)
> 
> I have the bcm3510-based board in my possesion right now, and both the
> nxt2002 and lgdt3303 versions are in the mail to me as I type this
> email.  (I plan to use the nxt2002 version to test and fix the nxt200x
> driver for this use.)
> 
> OTOH, if there are other reasons to stay away from this idea, say the
> word, and I'll send a revert patch to Andrew for the cx88 and saa7134
> stuff...  It is working well -- Gene reported a bug and I fixed it,
> already in Linus' tree.
> 
> What do you think?

I think b2c2-flexcop-pci uses a 240K dma buffer, whether you
save a few K in demodulator code doesn't mean much.
The saved memory will be similarly unnoticable to the user as
if you would go and scatter #ifdefs all over tuner-simple.c.

But I'm neither the author nor the maintainer of the b2c2-flexcop
driver, you better ask Patrick if he likes it.


Johannes
