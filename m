Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUEICRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUEICRe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 22:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUEICRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 22:17:34 -0400
Received: from mail.kroah.org ([65.200.24.183]:65440 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264261AbUEICRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 22:17:32 -0400
Date: Sat, 8 May 2004 19:16:52 -0700
From: Greg KH <greg@kroah.com>
To: dongzai007@sohu.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: vid&pid problems in usb_probe()
Message-ID: <20040509021652.GA11738@kroah.com>
Reply-To: linux-usb-devel@lists.sourceforge.net
References: <6918778.1084068239397.JavaMail.postfix@mx0.mail.sohu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6918778.1084068239397.JavaMail.postfix@mx0.mail.sohu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 10:03:54AM +0800, dongzai007@sohu.com wrote:
> Sorry, I forgot to tell you, I have copied all the header files in 
> "linux2.4.18/include/linux" to "/usr/include/linux". I am sure that
> there is no difference between "linux2.4.18/include/linux" and "/usr/include/linux"
> 
> I build this driver like this:
> 
> #gcc -c usb.c
> #insmod -f usb.o  //due to version dismatch, i should use -f
> 
> then plug a usb device.

That is _not_ the proper way to build a kernel module.  Please read the
Linux Device Drivers for examples of how to do this the correct way
(it's availble online for free.)

> Could you help me test this program? Do you have an usb device? You can write a program 
> like this, and test if it can report the right vid & pid.
> I downloaded a new kernel 2.6.5, after i started with the new kernel, lots of modules
> can not be loaded, so i changed back to 2.4.18, then I found my X-windows can not
> start. Did this error have something to do with this unstablity?

Did you read the release notes about how to move to the 2.6 kernel?  I
recommend using that one for development, as the USB interface is nicer,
and faster, and the build process is _vastly_ simpler.

Also, this belongs on the linux-usb-devel mailing list, not here.

greg k-h
