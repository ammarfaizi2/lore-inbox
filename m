Return-Path: <linux-kernel-owner+w=401wt.eu-S1751197AbXAPOYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXAPOYn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXAPOYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:24:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51082 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751197AbXAPOYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:24:42 -0500
Date: Tue, 16 Jan 2007 15:24:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.20-rc5: usb mouse breaks suspend to ram
Message-ID: <20070116142432.GA6171@elf.ucw.cz>
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I started using el-cheapo usb mouse... only to find out that it breaks
> >suspend to RAM. Suspend-to-disk works okay. I was not able to extract
> >any usefull messages...
> >
> >Resume process hangs; I can still switch console and even type on
> >keyboard, but userland is dead, and I was not able to get magic sysrq
> >to respond.
> 
> Are you using hid or usbmouse?

I think it is hid:

pavel@amd:/data/l/linux$ cat .config | grep MOUSE
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_USB_IDMOUSE is not set
pavel@amd:/data/l/linux$ cat .config | grep HID
CONFIG_BT_HIDP=y
# HID Devices
CONFIG_HID=y
CONFIG_USB_HID=y
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_PHIDGET is not set
pavel@amd:/data/l/linux$

Should I disable config_hid and try some other driver?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
