Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265162AbUFRODo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbUFRODo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUFRODo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:03:44 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:46725 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265162AbUFRODm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:03:42 -0400
Date: Fri, 18 Jun 2004 16:03:33 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Olaf Hering <olh@suse.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       4Front Technologies <dev@opensound.com>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618140332.GA19404@vana.vc.cvut.cz>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local> <20040618095700.GA22955@vana.vc.cvut.cz> <20040618134732.GA21216@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618134732.GA21216@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 03:47:32PM +0200, Olaf Hering wrote:
>  On Fri, Jun 18, Petr Vandrovec wrote:
> 
> > On Fri, Jun 18, 2004 at 03:20:48AM +0200, Roman Zippel wrote:
> > > On Thu, 17 Jun 2004, 4Front Technologies wrote:
> > > 
> > > > It's time everybody started to pay some attention to in-kernel interfaces because
> > > > Linux has graduated out of your personal sandbox to where other people want to use
> > > > Linux and they aren't kernel developers.
> > > 
> > > Look into your own diapers, learn the meaning of "documented interfaces" 
> > > and come back if you can show that SuSE broke exactly this.
> > 
> > If renaming /proc/bus/usb/devices to
> > /proc/bus/usb/devices_please-use-sysfs-instead is not breaking of
> > "documented interface" then I have no idea what "documented interface"
> > is...
> 
> I would not call this file an interface, but utter bullshit. Just
> because it breaks all these bullshit devices...

Yep. I'm not interested in the file contents, but in behavior of poll
on that file (which fires when device is plugged or unplugged).

Only thing which is at least simillar is dnotify on
/sys/bus/usb/devices, but as dnotify needs (preferrably RT) signal, it
is not trivial to use it from libraries due to problems with allocating
unused RT signal (and then you need some pipe to deliver notifications
from signal handler to "safe" process context).

Or do I miss some nice and simple interface which can be used for
notifications about newly plugged (USB) devices?
						Thanks,
							Petr Vandrovec

