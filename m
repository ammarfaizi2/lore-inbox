Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTL2NdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 08:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTL2NdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 08:33:21 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:9345 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263441AbTL2NdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 08:33:17 -0500
From: Duncan Sands <baldrick@free.fr>
To: "Guldo K" <guldo@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: speedtouch for 2.6.0
Date: Mon, 29 Dec 2003 13:34:01 +0100
User-Agent: KMail/1.5.4
References: <16366.61517.501828.389749@gargle.gargle.HOWL>
In-Reply-To: <16366.61517.501828.389749@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312291334.01173.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guldo, I assume you are using the kernel mode
driver (kernel module) and not the user mode driver
(pppoa2, pppoa3).  For that you need to compile the
kernel module.

> I'm trying to get this usb adsl modem to work
> with the latest stable kernel.
> I searched for this on the ML archive, and realized
> that the kernel module should be used.
> But I can't understand one thing (at least...)
> which consequences does the new alcatel module
> driver have on getting this modem to work?

It works the same as the module in 2.4.22 and later.
This module was originally only available outside the
kernel tree (it can be found for example in the
speedbundle on http://linux-usb.sf.net/SpeedTouch).
Now that it is in the kernel tree it is pointless to
compile it in the speedbundle (and it doesn't work
right now for 2.6 kernels).  Just turn it on in your
kernel .config and recompile your kernel.

> Does it override kernel setup described on
> the speedbundle site, or not?

Well, you still need to turn on ATM support etc,
but there is no need to patch the kernel for example.

> How should the kernel be compiled?

With

CONFIG_USB_SPEEDTOUCH=m

at least.

Ciao,

Duncan.
