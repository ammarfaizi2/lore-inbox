Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRALL6a>; Fri, 12 Jan 2001 06:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRALL6T>; Fri, 12 Jan 2001 06:58:19 -0500
Received: from linuxpc1.lauterbach.com ([194.195.165.177]:25374 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S129878AbRALL6C>; Fri, 12 Jan 2001 06:58:02 -0500
Message-Id: <5.0.2.1.2.20010112124122.00aa6020@mail.lauterbach.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 12 Jan 2001 12:57:26 +0100
To: Greg KH <greg@kroah.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [linux-usb-devel] [PATCH] USB Config fix for 2.2.19-pre7
Cc: linux-usb-devel@lists.sourceforge.net, f5ibh <f5ibh@db0bm.ampr.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010111232632.A19723@kroah.com>
In-Reply-To: <5.0.2.1.2.20010111175414.03377210@mail.lauterbach.com>
 <20010110002639.B26680@wirex.com>
 <20010110164451.A16985@kroah.com>
 <5.0.2.1.2.20010111175414.03377210@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:26 2001-01-12, Greg KH wrote:
>On Thu, Jan 11, 2001 at 06:01:19PM +0100, Franz Sirl wrote:
> > Why do the input handlers depend on CONFIG_USB_HID? On PPC we already have
> > trouble with them depending on CONFIG_USB, so everybody has to select
> > CONFIG_USB even if he just has ADB hardware.
>
>Don't these input drivers _require_ the USB HID driver core to work
>properly?

No.

>Or am I mistaken, and this is the 2.4.0 input core code, but
>not in a separate directory, like 2.4.0 has it?

Yes, it's the input core code, but without a separate directory or 
main_menu entry :-(. That means that currently on PPC people have to select 
CONFIG_USB even if they just want to have the input core code for 
CONFIG_INPUT_ADBHID. Since Alan rejected the creation of drivers/input in 
2.2 for unknown (?) reasons, I suggest to add a 2nd main_menu in 
usb/Config.in for CONFIG_INPUT items. Then adjust drivers/Makefile in a way 
that drivers/usb is entered if CONFIG_USB is unset but CONFIG_INPUT is set.

Franz.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
