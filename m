Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTEGFil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTEGFil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:38:41 -0400
Received: from fmr03.intel.com ([143.183.121.5]:2241 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S262874AbTEGFik convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:38:40 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FDF57@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: RE: [Bluetooth] HCI USB driver update. Support for SCO over HCI U
	 SB.
Date: Tue, 6 May 2003 22:51:07 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Greg KH [mailto:greg@kroah.com]
> 
> > If usb_init_urb() is already testing for !urb, why
> > test it again? No doubt the compiler will probably
> > catch it if inlining ... but I think the best is
> > for usb_init_urb() to assume that urb is not NULL.
> > Let the caller make that sure.
> 
> Because people other than usb_alloc_urb() can call usb_init_urb().
> Yeah, I can remove the check, then any invalid caller will oops on the

Just documenting it should do :]

> first line of usb_init_urb().  I don't mind, was just trying to program
> a bit more defensibly.  You know, make it a "hardened driver"  :)

Stab right in the heart :] I think we all agree we prefer "hardened
coders".

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
