Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRAKRB5>; Thu, 11 Jan 2001 12:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132969AbRAKRBr>; Thu, 11 Jan 2001 12:01:47 -0500
Received: from linuxpc1.lauterbach.com ([194.195.165.177]:14891 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S132958AbRAKRB3>; Thu, 11 Jan 2001 12:01:29 -0500
Message-Id: <5.0.2.1.2.20010111175414.03377210@mail.lauterbach.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 11 Jan 2001 18:01:19 +0100
To: linux-usb-devel@lists.sourceforge.net
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [linux-usb-devel] [PATCH] USB Config fix for 2.2.19-pre7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, f5ibh <f5ibh@db0bm.ampr.org>,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20010110164451.A16985@kroah.com>
In-Reply-To: <20010110002639.B26680@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:44 2001-01-11, Greg KH wrote:
>Hi,
>
>Here's a fix for the USB Config for 2.2.19-pre7.  I messed up and took
>out the HID devices in the patch I sent you for 2.2.19-pre6.

Why do the input handlers depend on CONFIG_USB_HID? On PPC we already have 
trouble with them depending on CONFIG_USB, so everybody has to select 
CONFIG_USB even if he just has ADB hardware.

Alan, would you accept a patch putting 2 main_menu's for CONFIG_USB and 
CONFIG_INPUT into usb/Config.in? This avoids the move of the input drivers 
into drivers/input as in 2.4 (which you seemingly don't want in 2.2) and 
only requires a minor adjustment in drivers/Makefile.

Franz.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
