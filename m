Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRKNB3Q>; Tue, 13 Nov 2001 20:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279952AbRKNB3I>; Tue, 13 Nov 2001 20:29:08 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:3858 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S279951AbRKNB2Y>;
	Tue, 13 Nov 2001 20:28:24 -0500
Date: Tue, 13 Nov 2001 18:27:19 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.8.4 is available
Message-ID: <20011113182718.A1630@kroah.com>
In-Reply-To: <20011113175010.A15716@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011113175010.A15716@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 16 Oct 2001 23:58:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 05:50:10PM -0500, Eric S. Raymond wrote:
> 
> CML2 is now fully caught up with the CML1 rulebase in the most current
> kernel version, with symbol coverage mechanically checked in both directions.

The following symbols should be allowed to be set to 'm' but are not:
	CONFIG_USB
	CONFIG_UHCI
	CONFIG_UHCI_ALT

If CONFIG_USB_SERIAL is set to 'y' CONFIG_USB_SERIAL_DEBUG should be
allowed to be chosen.  I do not see this happening.

And why is the CONFIG_USB_SERIAL options in the drivers/usb directory?
In the CML1 version they live in their own subdirectory quite nicely :)
Either way they should be in the USB port drivers section, not the "USB
devices" section of the menu.

There doesn't seem to be any rules set up for drivers/hotplug.

thanks,

greg k-h
