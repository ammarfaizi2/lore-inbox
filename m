Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280700AbRKNRBy>; Wed, 14 Nov 2001 12:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280707AbRKNRBo>; Wed, 14 Nov 2001 12:01:44 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:34067 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280700AbRKNRBc>;
	Wed, 14 Nov 2001 12:01:32 -0500
Date: Wed, 14 Nov 2001 10:00:21 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.8.4 is available
Message-ID: <20011114100020.A5287@kroah.com>
In-Reply-To: <20011113175010.A15716@thyrsus.com> <20011113182718.A1630@kroah.com> <20011114123325.A500@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011114123325.A500@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 17 Oct 2001 16:21:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 12:33:25PM -0500, Eric S. Raymond wrote:
> Greg KH <greg@kroah.com>:
> > The following symbols should be allowed to be set to 'm' but are not:
> > 	CONFIG_USB
> 
> That's odd.  M  shows up as a choice when I do xconfig.

Ok, this was a user error.  I didn't realize that the USB config option
was under the "System buses and controller types" menu.  This confusion
was caused by the error that you get when pressing "m" when the "USB
support" menu is selected on the main screen of the ncurses version.

> > And why is the CONFIG_USB_SERIAL options in the drivers/usb directory?
> > In the CML1 version they live in their own subdirectory quite nicely :)
> > Either way they should be in the USB port drivers section, not the "USB
> > devices" section of the menu.
> 
> Historical reasons.  My rulebase was opriginally one big file for editing
> conveniece.  What directory whould the USB serial stuff live in?

drivers/usb/serial

> > There doesn't seem to be any rules set up for drivers/hotplug.
> 
> What symbols should be in there,

CONFIG_HOTPLUG_PCI
CONFIG_HOTPLUG_PCI_COMPAQ
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM

See the Config.in file in that directory for the dependencies they have
on each other.

thanks,

greg k-h
