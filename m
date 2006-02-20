Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbWBTSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWBTSbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWBTSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:31:45 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:24582 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161108AbWBTSbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:31:44 -0500
Date: Mon, 20 Feb 2006 19:31:36 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)]
Message-ID: <20060220183136.GE33155@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>,
	Matthias Hensler <matthias@wspse.de>,
	Sebastian Kgler <sebas@kde.org>,
	kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219234212.GA1762@elf.ucw.cz> <200602201210.58362.nigel@suspend2.net> <20060220124937.GB16165@elf.ucw.cz> <20060220170537.GB33155@dspnet.fr.eu.org> <20060220171000.GF19156@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220171000.GF19156@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 06:10:00PM +0100, Pavel Machek wrote:
> On Po 20-02-06 18:05:37, Olivier Galibert wrote:
> > On Mon, Feb 20, 2006 at 01:49:37PM +0100, Pavel Machek wrote:
> > > > > Yep, if you do it all in userspace, this vanishes. 340 lines down.
> > > > 
> > > > And you gain? Let's try not to be too biased :).
> > > 
> > > I gain 340 less lines to review. For me to review, for akpm to review,
> > > and for Linus to review. That's important.
> > 
> > Pavel, if you mean that the userspace code will not be reviewed to
> > standards the kernel code is, kill uswsusp _NOW_ before it does too
> > much damage.  Unreliable suspend eats filesystems for breakfast.  The
> > other userspace components of the kernels services are either optional
> > (udev) or not that important (alsa).
> 
> At least it will be only me reviewing it, and not akpm and Linus.

Ok, your answer was saying the contrary (that you wouldn't review it
either).  Frankly, you may want akpm or Linus to do reviews of even
userspace code when appropriate, and others too like Al Viro.  They
have a freakingly good eye at detecting crap code.


> suspend2 received no such review, and still people claim it is
> reliable.

Plain numbers.  Just count the "suspend2 works for me which swsusp
doesn't".  I doubt it's purely luck, even if simply moving code around
can change behaviours.


> "I wish they'd kill suspend2 project, it already did enough
> damage." (Half joking here, but suspend2 split user/development
> community, and that's not good).

Yes, that's annoying.  But be careful, you seem to be automatically
rejecting everything Nigel at that point, or at least that's what it
looks like.

You do what you want, obivously, but I suspect your reviews of the
suspend2 code would be way more interesting if you accepted it's not
uswsusp.  Right now, they look more religious/political than really
technical.

Can you try doing a review where you temporarily accept suspend2's
kernel/userspace separation in the background, and review the code as
is?  That way you'll even have a chance to find out where the
differences in reliability are coming from.

  OG.

