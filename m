Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVCOTvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVCOTvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCOTrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:47:52 -0500
Received: from hagen.doit.wisc.edu ([144.92.197.163]:1920 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S261828AbVCOTpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:45:30 -0500
Date: Tue, 15 Mar 2005 19:45:25 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [RFC] Changes to the driver model class code.
In-reply-to: <20050315190847.GA1870@isilmar.linta.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Message-id: <1110915925l.6022l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.3.0
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Report: AuthenticatedSender=yes, SenderIP=146.151.41.63
X-Spam-PmxInfo: Server=avs-3, Version=4.7.1.128075, Antispam-Engine: 2.0.3.0,
 Antispam-Data: 2005.3.15.10, SenderIP=146.151.41.63
References: <20050315170834.GA25475@kroah.com>
 <20050315190847.GA1870@isilmar.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/05 13:08:47, Dominik Brodowski wrote:
> On Tue, Mar 15, 2005 at 09:08:34AM -0800, Greg KH wrote:
> > Then I moved the USB host controller code to use this new interface.
> > That was a bit more complex as it used the struct class and struct
> > class_device code directly.  As you can see by the patch, the result is
> > pretty much identical, and actually a bit smaller in the end.
> >
> > So I'll be slowly converting the kernel over to using this new
> > interface, and when finished, I can get rid of the old class apis (or
> > actually, just make them static) so that no one can implement them
> > improperly again...
> >
> > Comments?
> 
> Also, it seems to me that you view the class subsystem to be too closely
> related to /dev entries -- and for these /dev entries class_simple was
> introduced, IIRC. However, /dev is not the reason the class subsystem was
> introduced for -- instead, it describes _types_ of devices which want to
> share (userspace and in-kernel) interfaces.

Exactly.  I hope you take a close look at  
drivers/video/backlight/backlight.c and drivers/video/backlight/lcd.c and  
how it uses the class device.  Neither does not create anything in /dev.   
The model and design that is used in the backlight.c and lcd.c code is also  
being used in some (currently out of tree) new code I am working on.   
Either continue to support the current class API or provide a design and  
API that works with backlight.c

John

