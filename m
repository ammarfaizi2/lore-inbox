Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTLGEtC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 23:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTLGEtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 23:49:02 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:24803 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S265298AbTLGEs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 23:48:59 -0500
Date: Sat, 6 Dec 2003 21:48:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: Beaver in Detox!)
Message-ID: <20031207044857.GV912@stop.crashing.org>
References: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org> <20031128182625.GP2541@stop.crashing.org> <20031206184901.GH2455@meier-geinitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206184901.GH2455@meier-geinitz.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 07:49:01PM +0100, Henning Meier-Geinitz wrote:
> Hi,
> 
> On Fri, Nov 28, 2003 at 11:26:25AM -0700, Tom Rini wrote:
> > On Wed, Nov 26, 2003 at 12:55:00PM -0800, Linus Torvalds wrote:
> > 
> > [snip]
> > > I give you "Beaver in Detox", aka linux-2.6.0-test11. This is mainly
> > > brought on by the fact that the old aic7xxx driver was broken in -test10,
> > > and Ingo found this really evil test program that showed an error case in
> > > do_fork() that we had never handled right. Well, duh!
> > 
> > I've found an odd problem that's in at least 2.6.0-test11.
> 
> Did it happen in older versions of Linux? I haven't heard of any
> similar bug reports until now.

I hadn't tried.

> > I've
> > reproduced this twice now with an Epson 1240 USB scanner
> > (0x04b8/0x010b).  What happens is if I run xsane from gimp, acquire a
> > preview, start to scan and then cancel, the scanner becomes
> > unresponsive.
> 
> This may be a bug in the plustek backend which supports that scanner.
> The cancel handling is pretty complicated with some scanners.
> 
> > If I try and quit xsane, it gets stuck.
> 
> That sometimes happens with other scanners, too. E.g. some don't like
> to get a "stop scan" command in certain situations. They just hang
> after that command and further commands run into the USB timeout.
> 
> > Unplugging /
> > replugging and then trying to kill xsane locked the machine up hard.
> 
> Well, obviously that should't happen. But it's really hard to debug
> without any oops. There was a bug in the scanner driver that occured
> when a device was open, then unplugged and then an application wrote
> to it. But it's fixed since some time.
> 
> Does the freeze also happen if no other USB devices are attached? I guess
> working without a keyboard is not that easy but it may be worth a test.

I can xhost things to another machine rather easily.  But Greg KH talked
me into switching to libusb for the scanner, and everything works
perfectly now.  Do you still want me to give it a go?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
