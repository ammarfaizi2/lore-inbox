Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSIDVXo>; Wed, 4 Sep 2002 17:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSIDVXo>; Wed, 4 Sep 2002 17:23:44 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16399 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315485AbSIDVXn>;
	Wed, 4 Sep 2002 17:23:43 -0400
Date: Wed, 4 Sep 2002 14:26:20 -0700
From: Greg KH <greg@kroah.com>
To: Peter <cogweb@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
Message-ID: <20020904212620.GB8128@kroah.com>
References: <Pine.LNX.4.44.0209041311250.16204-100000@greenie.frogspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209041311250.16204-100000@greenie.frogspace.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 01:19:33PM -0700, Peter wrote:
> 
> Hi Greg -
> 
> Agree -- I couldn't find it either. This may be a makefile error:
> 
> linux-2.4.19-ac4 # grep usbdrv.o * -r
> Makefile:DRIVERS-$(CONFIG_USB) += drivers/usb/usbdrv.o
> drivers/usb/Makefile:O_TARGET   := usbdrv.o

Ah, stupid me, you were building USB into the kernel, so this is the usb
.o file.  Sorry for the confusion.

> The kernel compiled fine when I defined Input core support in the kernel
> rather than as modules (cf. below). And USB is working great -- keyboard, 
> cordless mouse, webcam, scanner, printer, the works.

Hm, I think you will have to compile the input stuff into the core, if
you want your USB input drivers to link properly.  So there's really no
way around this.

thanks,

greg k-h
