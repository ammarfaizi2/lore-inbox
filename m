Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUJRThP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUJRThP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUJRTgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:36:44 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:14504 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267657AbUJRTfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:35:00 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Jon Smirl <jonsmirl@gmail.com>
Date: Mon, 18 Oct 2004 12:34:45 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <4173B865.23362.117B098E@localhost>
In-reply-to: <9e47339104101610447a393abc@mail.gmail.com>
References: <416E6ADC.3007.294DF20D@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:

> > What this means is that it should be possible to build a new version of
> > the VESA framebuffer console driver for the Linux kernel that will have
> > these important features:
> > 
> > 1. Be able to switch display modes on the fly, supporting all modes
> > enumerated by the Video BIOS.
> > 
> > 2. Be able to support refresh rate control on graphics cards that support
> > the VBE 3.0 services.
> 
> How is this going to work if there are multiple graphics cards
> installed? Each card will want to install it's own VBE extension
> interrupt. 

Yep. The code I have ported to the Linux kernel right now does not 
support multiple consoles because porting that code would be a lot more 
work (I would prefer to keep it in userland if possible since it already 
works there).

Anyway the way the system works for multiple controllers is that there is 
a separate BIOS image and separate machine state maintained for each 
graphics card. So you can run the VBE driver on the primary, secondary 
and ternary drivers if you want. We do it all the time with SNAP just for 
fun and giggles ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


