Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVBGVAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVBGVAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVBGVA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:00:29 -0500
Received: from gprs215-44.eurotel.cz ([160.218.215.44]:50841 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261272AbVBGVAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:00:19 -0500
Date: Mon, 7 Feb 2005 21:59:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050207205958.GE8347@elf.ucw.cz>
References: <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com> <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com> <20050205093550.GC1158@elf.ucw.cz> <m1lla0187m.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lla0187m.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > We already try to do that, but it hangs on 70% of machines. See
> > > > Documentation/power/video.txt.
> > > 
> > > We know that all of these ROMs are run at power on so they have to
> > > work. This implies that there must be something wrong with the
> > > environment the ROM are being run in. Video ROMs make calls into the
> > > INT vectors of the system BIOS. If these haven't been set up yet
> > > running the VBIOS is sure to hang.  Has someone with ROM source and
> > > the appropriate debugging tools tried to debug one of these hangs?
> > > Alternatively code could be added to wakeup.S to try and set these up
> > > or dump the ones that are there and see if they are sane.
> > 
> > Rumors say that notebooks no longer have video bios at C000h:0; rumors
> > say that video BIOS on notebooks is simply integrated into main system
> > BIOS. I personaly do not know if rumors are true, but PCs are ugly
> > machines....
> 
> The state of current hardware has already been mentioned but let
> me clarify.  This is not a laptop problem anytime you have onboard
> video you are unlikely to have a separate video ROM.  This includes
> many recent server boards as well as laptops.  When the board boots
> up there will be a video option ROM shadowed into the usually location
> at C000h:0 but what becomes of it afterwards is a good question.
> 
> For server boards most commonly this seems to be a flavor of the ATI
> Rage XL chip.  It is a low end part that I doubt getting documentation
> for will be very hard.   And according to
> Documentation/power/video.txt this is one of the cases that actually
> works.

I do not see Rage XL mentioned in video.txt; can you give me details
and/or suggest a patch?

> What is happening in those POST routines of a video card is typically
> the code to initialize the memory controller on the video card.  Plus
> a little bit of code to set the video mode.  If I read the
> documentation correctly in a S3 power state only the RAM is preserved.
> So it does look like the video post is needed.

On some machines, video state is preserved over S3... Some BIOSes are
good enough to POST video for you...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
