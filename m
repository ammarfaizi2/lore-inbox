Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTLMNDD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 08:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbTLMNDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 08:03:02 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:43025 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264563AbTLMNDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 08:03:00 -0500
Date: Sat, 13 Dec 2003 14:14:05 +0100
To: Boszormenyi Zoltan <zboszor@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
Message-ID: <20031213131405.GA11073@hh.idb.hist.no>
References: <fa.da53dsa.dho216@ifi.uio.no> <20031212214310.GA744@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212214310.GA744@node1.opengeometry.net>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:43:10PM -0500, William Park wrote:
> On Fri, Dec 12, 2003 at 09:13:28AM +0000, Boszormenyi Zoltan wrote:
> > 
> > The functionality can be found at linuxconsole.sourceforge.net.
> > Will this be included into mainline near term? Say 2.6.[12]?
> > The ruby-2.6 is against 2.6.0-test9 so it's almost uptodate.
> 
> Does it work?
> 
It works with 2.6.0-test11.  Prepare a kernel source tree,
check out ruby from cvs, copy the ruby-2.6 parts into
the kernel tree.

I run my home machine this way:
2 standard keyboards, one connected to the keyboard port and
another connected to the ps2 mouse port.
2 mice, both connected to serial ports.
2 screens, connected to the two outputs of a matrox G550.

One xserver runs using standard mga driver, another xserver
uses the unaccelerated framebuffer driver on the framebuffer
displayed on the second screen.

The screen with the accelerated server also have accelerated opengl.
The other screen uses software opengl, fast enough for
frozen-bubble and rocks&diamonds, but not for tuxracer.

xdm manages both screens, so any user can log in at either screen.

The G550 isn't ideal for this, because resetting the accelerated xserver
causes the framebuffer screen to blink (accelerated xserver 
disturbs the other display while setting resolution.)
This is a software problem though.

It seems possible to run accelerated servers at both screens as
long as only one uses opengl.  I haven't bothered yet because
unaccelerated 2D performance seems fine for all purposes with
dual 333MHz processors.  


Using two video cards AGP+PCI or PCI+PCI solves the interactions between
the two displays, but then you need a modified xserver. (Std.
Xserver turns off video cards it donesn't use, without worrying
about other servers using the other card.)  

Letting two servers use a single card don't have this problem,
but it could possibly have other problems.

Helge Hafting

