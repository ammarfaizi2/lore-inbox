Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTLTVm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTLTVm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:42:29 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:60290
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261552AbTLTVm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:42:27 -0500
Date: Sat, 20 Dec 2003 16:41:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Armin <Zoup@zoup.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       unki@netshadow.at
Subject: Re: FrameBuffer Problem With 2.6.0
In-Reply-To: <2CA1166592F@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.58.0312190917520.2147@montezuma.fsmlabs.com>
References: <2CA1166592F@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, Petr Vandrovec wrote:

> On 18 Dec 03 at 23:29, Armin wrote:
> > On Thursday 18 December 2003 00:35, Andreas Unterkircher wrote:
> > > I had similar the same Problem... i fixed it when i also put the
> >
> > i have compile kernel with vga fonts , Still are not working ...
>
> And did you enable framebuffer console support in Device Drivers ->
> Graphics Support -> Console display driver support -> Framebuffer Console
> Support ? It looks to me like that you did not enabled this, and so you
> get hardware in graphics mode (when fbdev loads), but no text there (as
> there is no fbcon in your kernel). 2.6.x kernel has strange idea
> that non-embedded users need fbdev without fbcon by default...
>
> I'm not aware about any problems with matroxfb driver in Linus kernel
> except that you should use 'video=matroxfb:nopan' to avoid problems
> with default resolution XXXx65536 (or clip vyres yourself to reasonable
> value). Of course all 2.6.x fbdev limits apply also to matroxfb driver.
> If you want interface compatible with 2.4.x, you'll have to get patch
> from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0.gz
> (only vgacon, matroxfb and vesafb are tested).

I'm fielding a bug report from someone which is related to the EDID
changes here;

http://bugzilla.kernel.org/show_bug.cgi?id=1458

Do you think they may be related?
