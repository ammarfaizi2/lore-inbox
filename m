Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbUKKTbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUKKTbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbUKKTbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:31:04 -0500
Received: from pop.gmx.net ([213.165.64.20]:6367 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262310AbUKKTbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:31:00 -0500
X-Authenticated: #22934420
From: Gregor Jasny <gjasny@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: USB-1.1 fails with USB 2.0 Hub [was: Re: USB-Serial fails with USB 2.0 Hub]
Date: Thu, 11 Nov 2004 20:30:46 +0100
User-Agent: KMail/1.7
References: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com> <200411112003.43598.Gregor.Jasny@epost.de>
In-Reply-To: <200411112003.43598.Gregor.Jasny@epost.de>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200411112030.46563.gjasny@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 November 2004 20:03, you wrote:
> On Monday 08 November 2004 16:49, you wrote:
> > Two problems with kernel 2.6.4 (SuSe 9.1):
> >
> > 1) When I use a Belkin F5U409 usb-serial converter:
> >      - when plugged directly into chipset (Intel ICH5), works great.
> >      - when plugged in through a USB 1.0 hub, works great
> >      - when plugged in throught USB 2.0 Hub (Belkin F5U237), fails.
> >        Failure mechanism is: Tx works, Rx does not.
>
> Just a simple me, too. I've got the problem with a TerraCAM USB Pro.
> Plugged into my Apple Keyboard it works (with a warning about high power
> consumption). But if I plug it into my Belkin F5U237 the driver complains
> with: "drivers/usb/media/ov511.c: init isoc: usb_submit_urb(0) ret -38".

A simple list of working and nonworking devices:

Works:
* Logitech MouseMan Optical Dual
* Apple Pro Keyboard
* Iomega ZIP 100

Works not:
* TerraCAM USB Pro: (ov511 v2.28)
drivers/usb/media/ov511.c: init isoc: usb_submit_urb(0) ret -38

* USB-to-Serial (pl2303)
pl2303_open - failed submitting interrupt urb, error -28


Perhaps a driver programming bug?

Cheers,
-Gregor
