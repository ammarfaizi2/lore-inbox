Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbTGMEOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270096AbTGMENU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:13:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:18902 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270095AbTGMENI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:13:08 -0400
Date: Sat, 12 Jul 2003 21:08:01 -0700
From: Greg KH <greg@kroah.com>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.7.75] Misc compiler warnings
Message-ID: <20030713040801.GA2695@kroah.com>
References: <1058053975.12250.2.camel@sm-wks1.lan.irkk.nu> <1058055803.12256.27.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058055803.12256.27.camel@sm-wks1.lan.irkk.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 02:23:29AM +0200, Christian Axelsson wrote:
> On Sun, 2003-07-13 at 01:52, Christian Axelsson wrote:
> > Here are some compiler warnings:
> > 
> >   CC      drivers/i2c/i2c-dev.o
> > drivers/i2c/i2c-dev.c: In function `show_dev':
> > drivers/i2c/i2c-dev.c:121: warning: unsigned int format, different type
> > arg (arg 3)
> > 
> >   CC      drivers/usb/core/file.o
> > drivers/usb/core/file.c: In function `show_dev':
> > drivers/usb/core/file.c:96: warning: unsigned int format, different type
> > arg (arg 3)
> > 
> >   AS      arch/i386/boot/setup.o
> > arch/i386/boot/setup.S: Assembler messages:
> > arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> > 0x37ffffff
> 
> Ehm sorry, I should say that this is 2.5.75-mm1
> 
> On 2.5.75-vanilla only the AS message occour.

That is due to the size of dev_t being bigger in the -mm tree.  When
that moves to the main kernel tree, I'll fix up the usb and i2c
warnings.

thanks,

greg k-h
