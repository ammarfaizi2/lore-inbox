Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWAFK2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWAFK2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbWAFK2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:28:55 -0500
Received: from [213.13.124.66] ([213.13.124.66]:40074 "EHLO mail.paradigma.pt")
	by vger.kernel.org with ESMTP id S1751854AbWAFK2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:28:54 -0500
Date: Fri, 6 Jan 2006 10:28:48 +0000
From: Nuno Monteiro <nuno+lkml@itsari.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Roberto Nibali <ratz@drugphish.ch>,
       "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
Message-ID: <20060106102848.GA6854@hobbes.itsari.org>
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch> <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr> <43BD146B.2010308@drugphish.ch> <20060105210751.GC4332@hobbes.itsari.org> <43BDABA1.1060607@drugphish.ch> <Pine.LNX.4.61.0601060752110.22809@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.61.0601060752110.22809@yvahk01.tjqt.qr> (from jengelh@linux01.gwdg.de on Fri, Jan 06, 2006 at 07:01:26 +0000)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006.01.06 07:01, Jan Engelhardt wrote:
> 
> >> rid of the extra fluff -- the dependency on moduleparm.h which
> >> doesn't exit in 2.4.22
> 
> Good to know.

IIRC, it was introduced in 2.4.25. Since I'm still running 2.4.22, and
since I also didn't need the 2.6 module_param() stuff, I just ripped it
out.

> >> the BSD defines
> 
> In the kernel part? Where?

Not in the driver itself, of course, in rpl_ioctl.h and rpl_packet.h.

> >> the 2.6 defines, etc. Also, if built as a
> >> module, it'll be called 'rpl' instead of 'rpldev'.
> >
> > Why?
> 
> By default, it's called rpldev everywhere.

Yeah, it was just my personal preference. That, and the fact that I
don't know the build system very well, and the O_TARGET and the obj-y
couldn't have the same name. So I opted to make O_TARGET simply rpl.o.
Since the driver you ship in the ttyrpld tarball can only be built
modular, this doesn't affect you anyway :-)

 
> I will have 2.4 put back in.

That'd be great, thanks! A great deal of people are still running 2.4 on
their production servers, and no intention to upgrade anytime soon. If
it's not broken... :-)

Thanks for this tool, by the way, I for one find it very useful!


Regards,

		Nuno

-- 
Nuno Monteiro <nuno+spamtrap@itsari.org> pgp key 8DEF0334
