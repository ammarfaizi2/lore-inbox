Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVJSNXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVJSNXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 09:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVJSNXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 09:23:41 -0400
Received: from p54B0599B.dip.t-dialin.net ([84.176.89.155]:24274 "EHLO
	ccc-offenbach.org") by vger.kernel.org with ESMTP id S1750929AbVJSNXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 09:23:40 -0400
Date: Wed, 19 Oct 2005 15:23:26 +0200
From: Rudolf Polzer <debian-ne@durchnull.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051019132326.GA31526%atfield-dt@durchnull.de>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain> <20051018171645.GA59028%atfield-dt@durchnull.de> <m3fyqyhdm8.fsf@defiant.localdomain> <20051018204919.GA21286%atfield-dt@durchnull.de> <m3oe5l21rr.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m3oe5l21rr.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsis, quam aut quem »Krzysztof Halasa« appellare soleo:
> Rudolf Polzer <debian-ne@durchnull.de> writes:
> > However, pool computers like in this case are neither servers nor
> > terminals.  If they were terminals, we would need about 30 servers to
> > handle the load of 100 active students. So they are workstation
> > installations that do most of the work locally.
> 
> Ok. So they are exposed to known attacks with quite high probability.

Which others? Are there other places that assume only trusted users can access
the console?

> >> Hope they don't change the keys in the process.
> >
> > They HAVE to do that,
> 
> Well, I meant physical keys to match them to loaded keymaps :-)

;)

> > However, Xorg and XFree86 have about the same problem: you can remap
> > Ctrl-Alt-Backspace. So it would be good if the SAK also worked there which
> > would require it to set a "sane" video mode.
> 
> I assume that one can notice that Ctrl-Alt-Backspace doesn't work,
> and stop there.

Not if a malicious X program does "chvt 1; chvt 7" when Ctrl-Alt-Backspace is
pressed.

> I think SAK/X11 video mode issue is possible to fix, though.

It would require a video driver that can actually reset the video mode.
Framebuffer drivers usually can do that. For the standard VGA text mode, at
least savetextmode/restoretextmode from svgalib don't work on the graphics
cards I have.
