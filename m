Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRHaXAd>; Fri, 31 Aug 2001 19:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHaXAX>; Fri, 31 Aug 2001 19:00:23 -0400
Received: from mercury.mv.net ([199.125.85.40]:58640 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S269726AbRHaXAU>;
	Fri, 31 Aug 2001 19:00:20 -0400
Message-ID: <002801c13270$86592680$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: "Greg KH" <greg@kroah.com>, "Carlos E Gorges" <carlos@techlinux.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <01083019402502.01265@skydive.techlinux> <20010830161809.A19258@kroah.com>
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2
Date: Fri, 31 Aug 2001 18:58:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




----- Original Message -----
From: "Greg KH" <greg@kroah.com>
To: "Carlos E Gorges" <carlos@techlinux.com.br>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 30, 2001 7:18 PM
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2


> On Thu, Aug 30, 2001 at 07:40:25PM -0300, Carlos E Gorges wrote:
> > Hardware detection tool 0.2
> >
> > The main idea is keep a unified database of modules and
> > create a good tool for hardware configurators.
>
> Why don't you just pull the PCI and USB module information out of the
> drivers themselves?  All the information you need it in the
> MODULE_DEVICE_TABLE() macro.  You don't get a pretty vendor string for
> most all of the USB devices that use a USB class spec, but that isn't
> necessary.

One reason: Not all hardware has the signals needed to detect when a card
gets plugged or unplugged.  Consider legacy cPCI systems.  The don't have
the Hot Swap extensions or backplane hot swap control.  The only way to find
the cards is to periodically scan the bus for new cards, cards that
disappeared, or requests for Hot Swap.


