Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289652AbSAWE7X>; Tue, 22 Jan 2002 23:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289668AbSAWE7N>; Tue, 22 Jan 2002 23:59:13 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:48146 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289652AbSAWE6z>;
	Tue, 22 Jan 2002 23:58:55 -0500
Date: Tue, 22 Jan 2002 20:54:05 -0800
From: Greg KH <greg@kroah.com>
To: Torrey Hoffman <thoffman@arnor.net>, vojtech@ucw.cz
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: depmod problem for 2.5.2-dj4
Message-ID: <20020123045405.GA12060@kroah.com>
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1011744752.2440.0.camel@shire.arnor.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 26 Dec 2001 02:40:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 04:12:30PM -0800, Torrey Hoffman wrote:
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.2-dj4/kernel/drivers/usb/hid.o
> depmod: 	usb_make_path
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.2-dj4/kernel/drivers/usb/usbkbd.o
> depmod: 	usb_make_path
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.2-dj4/kernel/drivers/usb/usbmouse.o
> depmod: 	usb_make_path
> make: *** [_modinst_post] Error 1

Looks like you need to add a:
	EXPORT_SYMBOL(usb_make_path);
to the usb.c file.

Vojtech, is this a USB function that you want added to usb.c?
Didn't you (or someone else) propose a function like this in the past?

thanks,

greg k-h
