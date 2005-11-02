Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbVKBHnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVKBHnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVKBHnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:43:08 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:4242 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932623AbVKBHnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:43:06 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 08:42:59 +0100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
References: <4363F9B5.6010907@free.fr> <200511011340.41266.duncan.sands@math.u-psud.fr> <1130850242.21212.29.camel@hades.cambridge.redhat.com>
In-Reply-To: <1130850242.21212.29.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020843.01004.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tuesday 1 November 2005 14:04, David Woodhouse wrote:
> On Tue, 2005-11-01 at 13:40 +0100, Duncan Sands wrote:
> > this code looks like a 'orrible hack to work around a common problem
> > with USB modem's of this type: if the modem is plugged in while the
> > system boots, the driver may look for firmware before the filesystem
> > holding the firmware is mounted; I guess the delay usually gives
> > the filesystem enough time to be mounted.  I'm told that the correct
> > solution is to stick the firmware in an initramfs as well. 
> 
> Why can't we request the firmware again when the device is first used,
> if it wasn't present when the driver was first loaded?

we could do this for the speedtouch - in fact we used to do this: when
someone tried to open a connection, we loaded the firmware if it hadn't
been loaded yet.  The problem is with other modems, like the connexant
access runner, for which you can't get all the info needed to create
an ATM device before the firmware is loaded (the MAC address for example).

Ciao,

D.
