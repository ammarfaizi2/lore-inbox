Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSDEGrn>; Fri, 5 Apr 2002 01:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312326AbSDEGrd>; Fri, 5 Apr 2002 01:47:33 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:36363 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312316AbSDEGrS>;
	Fri, 5 Apr 2002 01:47:18 -0500
Date: Thu, 4 Apr 2002 22:45:45 -0800
From: Greg KH <greg@kroah.com>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.7-dj3 - BUG & PATCH
Message-ID: <20020405064545.GA19248@kroah.com>
In-Reply-To: <20020404054923.A28437@suse.de> <20020404172238.62bf1d41.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 08 Mar 2002 02:10:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 05:22:38PM +0200, Sebastian Droege wrote:
> Hi,
> I have a problem in 2.5.7-dj3 which doesn't exist in 2.5.8-pre1...
> My USB keyboard and mouse are detected properly but aren't usable
> I get the same behaviour when unsetting CONFIG_USB_HIDINPUT in 2.5.8-pre1
> grepping for CONFIG_USB_HIDINPUT in 2.5.7-dj3 finds something but the option doesn't show in old/menuconfig
> When setting CONFIG_USB_HIDINPUT=y by hand in 2.5.7-dj3 I get a compile error:
> 
> make[3]: Entering directory `/usr/src/linux-2.5.7/drivers/usb'
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O6 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=hid_input  -c -o hid-input.o hid-input.c
> hid-input.c:335: redefinition of `hidinput_hid_event'
> hid.h:411: `hidinput_hid_event' previously defined here
> hid-input.c:413: redefinition of `hidinput_connect'
> hid.h:412: `hidinput_connect' previously defined here
> hid-input.c:458: redefinition of `hidinput_disconnect'
> hid.h:413: `hidinput_disconnect' previously defined here
> make[3]: *** [hid-input.o] Fehler 1

I can't duplicate this, can you send me your .config?

thanks,

greg k-h
