Return-Path: <linux-kernel-owner+w=401wt.eu-S1751318AbXAPVZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAPVZZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 16:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbXAPVZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 16:25:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14286 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbXAPVZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 16:25:24 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S8XWQpC0B6hS9Ol9vQztIH8voZBvBAUVh2teZee0ocuz9OBb20+xSOzo53A0UPIDyaR3FZdJaDnjlH8byu1mR6QfTCSpypWeojzei5BlI1GekGQE1apUkCojfyRCLebLLZGTMvockmkoDC4c+Kb2DEkpBY20QC1MobxbN1VvxQc=
Message-ID: <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com>
Date: Tue, 16 Jan 2007 16:25:20 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: 2.6.20-rc5: usb mouse breaks suspend to ram
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "Linux usb mailing list" <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20070116142432.GA6171@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070116135727.GA2831@elf.ucw.cz>
	 <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com>
	 <20070116142432.GA6171@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/07, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > >I started using el-cheapo usb mouse... only to find out that it breaks
> > >suspend to RAM. Suspend-to-disk works okay. I was not able to extract
> > >any usefull messages...
> > >
> > >Resume process hangs; I can still switch console and even type on
> > >keyboard, but userland is dead, and I was not able to get magic sysrq
> > >to respond.
> >
> > Are you using hid or usbmouse?
>
> I think it is hid:
>
> pavel@amd:/data/l/linux$ cat .config | grep MOUSE
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_SERIAL=y
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_USB_IDMOUSE is not set
> pavel@amd:/data/l/linux$ cat .config | grep HID
> CONFIG_BT_HIDP=y
> # HID Devices
> CONFIG_HID=y
> CONFIG_USB_HID=y
> # CONFIG_USB_HIDINPUT_POWERBOOK is not set
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
> # CONFIG_USB_PHIDGET is not set
> pavel@amd:/data/l/linux$
>
> Should I disable config_hid and try some other driver?

No, HID is the preferred... I am not sure what is going on - on my box
STR does not work at all thanks to nvidia chip turning the display on
all the way as the very last step of suspend ;(

-- 
Dmitry
