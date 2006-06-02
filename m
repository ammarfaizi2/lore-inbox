Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWFBJEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWFBJEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWFBJEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:04:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44449 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751344AbWFBJEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:04:02 -0400
Date: Fri, 2 Jun 2006 11:03:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Dave Airlie <airlied@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060602090313.GC25806@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz> <200606011603.57421.dhazelton@enter.net> <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 01-06-06 16:35:12, Jon Smirl wrote:
> On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> >> > 5) The system needs to be robust. Daemons can be killed by the OOM
> >> > mechanism, you don't want to lose your console in the middle of trying
> >> > to fix a problem. This also means that you have to be able to display
> >> > printk's from inside interrupt handles.
> >
> >Point of disagreement. Tons of userspace helpers isn't a good choice.
> 
> Where do you get 'tons'? There will probably be one for initial reset,
> one for VESA based mode setting and a few more if there is device
> specific code needed for a specific card.
> 
> Making console rely on a permanent daemon that is subject to getting
> killed by the OOM mechanism is not a workable solution.

Well, you keep forgetting that temporary programs are _also_ subject
to OOM, and that -- in case of problems -- exec() is less likely to
work than most other things.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
