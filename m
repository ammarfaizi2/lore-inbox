Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbVKBIC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVKBIC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVKBIC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:02:29 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53415 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932634AbVKBIC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:02:28 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 09:02:26 +0100
User-Agent: KMail/1.8.3
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <4363F9B5.6010907@free.fr> <200511020843.01004.duncan.sands@math.u-psud.fr> <1130917501.10031.149.camel@baythorne.infradead.org>
In-Reply-To: <1130917501.10031.149.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020902.26979.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 2 November 2005 08:45, David Woodhouse wrote:
> On Wed, 2005-11-02 at 08:42 +0100, Duncan Sands wrote:
> > we could do this for the speedtouch - in fact we used to do this: when
> > someone tried to open a connection, we loaded the firmware if it
> > hadn't been loaded yet.  The problem is with other modems, like the
> > connexant access runner, for which you can't get all the info needed
> > to create an ATM device before the firmware is loaded (the MAC address
> > for example).
> 
> Don't we also have Ethernet devices like that -- where the MAC address
> doesn't get set until you bring the device up?
> 
> Can we get away with changing the MAC address later? Or is there other
> stuff we need earlier?

Hi David, it's only the MAC address.  I didn't check carefully, but I'm pretty
sure that in general the MAC address is the only device dependant info needed
to setup an ATM device.  But isn't changing the MAC address later a horrible
hack that is sure to break stuff?

Duncan.
