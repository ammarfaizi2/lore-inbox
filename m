Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTLATtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTLATtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 14:49:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:28037 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263930AbTLATtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 14:49:22 -0500
Date: Mon, 1 Dec 2003 11:21:58 -0800
From: Greg KH <greg@kroah.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, henning@meier-geinitz.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: USB scanner issue (Was: Re: Beaver in Detox!)
Message-ID: <20031201192158.GC23209@kroah.com>
References: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org> <20031128182625.GP2541@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128182625.GP2541@stop.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 11:26:25AM -0700, Tom Rini wrote:
> On Wed, Nov 26, 2003 at 12:55:00PM -0800, Linus Torvalds wrote:
> 
> [snip]
> > I give you "Beaver in Detox", aka linux-2.6.0-test11. This is mainly
> > brought on by the fact that the old aic7xxx driver was broken in -test10,
> > and Ingo found this really evil test program that showed an error case in
> > do_fork() that we had never handled right. Well, duh!
> 
> I've found an odd problem that's in at least 2.6.0-test11.  I've
> reproduced this twice now with an Epson 1240 USB scanner
> (0x04b8/0x010b).  What happens is if I run xsane from gimp, acquire a
> preview, start to scan and then cancel, the scanner becomes
> unresponsive.  If I try and quit xsane, it gets stuck.  Unplugging /
> replugging and then trying to kill xsane locked the machine up hard.
> 
> Here's ver_linux, dmesg and the versions of gimp/xsane I'm running (I've
> used the scanner during this boot, without trying to lock it up):

Can't you use xsane without the scanner kernel driver?  I thought the
latest versions used libusb/usbfs to talk directly to the hardware.
Because of this, the USB scanner driver is marked to be removed from the
kernel sometime in the near future.

thanks,

greg k-h
