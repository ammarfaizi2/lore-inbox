Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWFAWWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWFAWWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFAWWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:22:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35276 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750787AbWFAWW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:22:29 -0400
Date: Fri, 2 Jun 2006 00:21:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Dave Airlie <airlied@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060601222140.GB3054@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz> <200606011603.57421.dhazelton@enter.net> <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com> <447F56A0.8030408@gmail.com> <9e4733910606011423u75fa076hce22547c28c0a987@mail.gmail.com> <447F5CB3.7000107@gmail.com> <9e4733910606011448x32246dfcy2a2d448e238bdab3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4733910606011448x32246dfcy2a2d448e238bdab3@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 01-06-06 17:48:57, Jon Smirl wrote:
> On 6/1/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >Jon Smirl wrote:
> >> On 6/1/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >>> Jon Smirl wrote:
> >>> > On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> >>> >
> >>>
> >>> Console writes are done with the console semaphore held. printk will 
> >also
> >>> just write to the log buffer and defer the actual console printing
> >>> for later, by the next or current process that will grab the semaphore.
> >>
> >> That was my original position too. But Alan Cox has drilled it into me
> >> that this is not acceptable for printks in interrupt context, they
> >> need to print there and not be deferred.
> >>
> >
> >Just to clarify, it's not my position, that's how the current printk code
> >works.
> 
> I haven't looked at the code, but if there is just normal console
> running and nothing like X is around, doesn't the console system
> always have the semaphore? 

Not if foreground code is already printing something. Fortunately we
do not spend most of time printing text; that's why printk from
interrupt usually works.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
