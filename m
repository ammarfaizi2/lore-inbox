Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVDOKKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVDOKKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 06:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDOKKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 06:10:10 -0400
Received: from mail.zmailer.org ([62.78.96.67]:29351 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261794AbVDOKKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 06:10:00 -0400
Date: Fri, 15 Apr 2005 13:09:59 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Jeff Lessem <linux-kernel@lists.lessem.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad T42 - Looking for a Developer.
Message-ID: <20050415100959.GP3858@mea-ext.zmailer.org>
References: <003901c54136$6ba545c0$9f0cc60a@amer.sykes.com> <Pine.LNX.4.62.0504142317480.3466@dragon.hyggekrogen.localhost> <20050414223641.M49815@linuxwireless.org> <20050414231513.GN3858@mea-ext.zmailer.org> <200504142354.j3ENsYj3028900@ibg.colorado.edu> <425F32E8.8090407@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F32E8.8090407@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Thu, Apr 14, 2005 at 10:20:08PM -0500, Alejandro Bonilla wrote:
> Matti,
> 
> Where do we stand here? Now that you have two of those outputs, so I 
> can have some hope... Do you think we can make the driver for this
> hardware?
> 
> How about the firmware that the documents mention? Could there be a 
> layer in the hardware itself that might prevents us from reading the 
> fingerprint image?

The hardware exists for fingerprint reading.
It is all a matter of understanding of how to talk to those BULK endpoints
to do proper communication, and that is somewhat challening without
that level of documentation.

In USB documents that kind of document is known as "Device Class Definition"

  idVendor           0x0483 SGS Thomson Microelectronics
  idProduct          0x2016
  iManufacturer           1 STMicroelectronics
  iProduct                2 Biometric Coprocessor
    Interface Descriptor:
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0

This "Vendor Specific Class" means it needs specific document,
not only USB Implementers' Forum:s  generic documents.


Windows driver binary does implement it, and (at least in EU) it is
perfectly legal to reverse engineer something in order to produce
compatible products or to use something that isn't completely
documented.

Nevertheless I would prefer to have documents about actual communication
messages that are exchanged over those endpoints.  That would speed up
driver writing considerably. 

> Will BioAPI help us at all, or the best approach here is not to make 
> dll wrapping?

At least I prefer not to mess with (windows-)DLL-wrapping.
Linux exists in quite a many platforms, and the BioAPI library does
already exist for Linux in source form as well.

That reference BioAPI implementation needs very least the backend
driver of the actual reader.  What else does it need, I can't say
without doing experimentation and code reading.

If the necessary document is deep NDA for some reason, we can
negotiate with the vendor about how obfuscated version of the
resulting driver source can be included in open source distributions.

> Thanks for you all time,
> - Alejandro

/Matti Aarnio
