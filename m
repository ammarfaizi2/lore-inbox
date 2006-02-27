Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWB0JOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWB0JOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWB0JOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:14:52 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34946 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932320AbWB0JOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:14:50 -0500
From: Duncan <1i5t5.duncan@cox.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.16-rc5: known regressions (ps2 mouse/keyboard issues)
Date: Mon, 27 Feb 2006 02:14:48 -0700
User-Agent: KMail/1.9.1
Cc: Ryan Phillips <ryan@trolocsis.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <44029BA1.8030601@trolocsis.com> <20060227063930.GA8018@suse.cz>
In-Reply-To: <20060227063930.GA8018@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602270214.49281.1i5t5.duncan@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 February 2006 23:39, Vojtech Pavlik wrote:
> On Sun, Feb 26, 2006 at 10:26:41PM -0800, Ryan Phillips wrote:
> > Adrian Bunk wrote:
> > > This email lists some known regressions in 2.6.16-rc5 compared to
> > > 2.6.15.
[snip]
> > > Subject    : usb_submit_urb(ctrl) failed on 2.6.16-rc4-git10 kernel
> > > References : http://bugzilla.kernel.org/show_bug.cgi?id=6134
> > > Submitter  : Ryan Phillips <rphillips@gentoo.org>
> > > Status     : unknown
[snip]
> > > Subject    : total ps2 keyboard lockup from boot
> > > References : http://bugzilla.kernel.org/show_bug.cgi?id=6130
> > > Submitter  : Duncan <1i5t5.duncan@cox.net>
> > > Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >              Pavlik Vojtech <vojtech@suse.cz>
> > > Status     : discussion and debugging in the bug logs
> >
> > It appears that Duncan's "total ps2 keyboard lockup from boot" is the
> > same, or similar problem as mine.
> > 2.6.15.1 kernel is working for me though.
>
> Except one of the keyboards is USB and the other PS/2. Both are
> Microsoft wireless, though.

As Ryan observes in his bug, the keyboard and mouse were both plugged into the 
ps2 ports.  Same keyboard, both amd64, both with both the mouse and keyboard 
plugged into the ps2 ports, both with a dead keyboard before rc1. As he says, 
evidence suggests it is indeed the same bug.  Also, we're both on Gentoo, but 
that could simply be due to the fact that Gentoo folks are probably more 
likely to be running rc or even git kernels than most, due to the type of 
distribution it is and GregKH's recently adding mainline git snapshots to the 
package tree to encourage quicker testing.

One discrepancy so far: Ryan mentions git10, implying it failed for him, while 
git10 works here but git11 fails.  My guess is that the USB error he 
originally keyed in on, that turned out to be happening with working kernels 
too, sent him down the wrong path, and git10 will end up working for him.  
Either that or the root issue is something that changed in git10, and then 
again in git11, killing his one day and mine the next, due to the mobo 
differences or something.

-- 
Duncan - Plain text mail please, HTML mail filtered as spam
"They that can give up essential liberty to obtain a little
temporary safety, deserve neither liberty nor safety."
Benjamin Franklin
