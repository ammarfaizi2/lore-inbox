Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274815AbTHKTRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273403AbTHKTQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:16:56 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:23228 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S274809AbTHKTOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:14:53 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jocelyn Mayer <l_indien@magic.fr>
Date: Mon, 11 Aug 2003 21:14:38 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test2 does not boot with matroxfb
Cc: davej@codemonkey.org.uk, linux kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <9DA76F97593@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Aug 03 at 21:00, Jocelyn Mayer wrote:
> > On Mon, 2003-08-11 at 20:29, Petr Vandrovec wrote:
> > On 11 Aug 03 at 20:01, Jocelyn Mayer wrote:
> > > I now run a VGA console kernel without agpgart with a 16bps X.
> > > 
> > > So, there seems to be two issues:
> > > - broken matrox fb: I lose the synchro when switching from X to fb.
> > >   fbset configuration is lost when switching consoles.
> > 
> > It is feature, not a bug. fbset does not work on 2.6.x kernels
> > anymore. Apply 
> > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0-t3-c1149.gz
> > if you prefer 2.4.x behavior.
> > 
> In fact, it works untill I switch to another console...
> What is the right way to change the console configuration at run-time,
> now ? Or where should I look for this info ?
> Did it become impossible (would be a severe bug, at least for me...) ?

"stty cols XXX rows YYY" sets size. How you'll set pixclock, color depth
or other features is unknown to me - I use my patch above and others
should ask James Simmons...

> > Also if you are using DRI, even latest XFree mga driver I found still 
> > reprograms hardware even if XFree server is not on a foreground, so you 
> > must use same color depth and vxres for both X and console, and even in 
> > this configuration display corruption on console may occur from time to
> > time...
> >                                             Petr Vandrovec
> >        
> OK, you confirm exactly the symptom I have seen.
> So it seems to be an X driver problem...
> But X is still buggy when it doesn't use DRI,
> at least in 32 bits modes. I know it's quite certain that it's an X bug,
> but I really would like to understand why it works with 2.4 kernels
> and not with 2.6 ones. The X problem is there even if I use the VGA
> console (I mean with a kernel with fb support _not_ activated).

In 2.4.x kernels dri refused to work on couple of systems I have, while
in 2.6.x it is willing to work even on more systems - if we are talking
about console.

I do not know why you have problems with X - 2.6.0-test3-bk-current
works for me with G200, G450 and G550 with Debian's unstable XFree,
(16/16bpp on G550 system and 24/32bpp on others).
                                                Petr
                                                

