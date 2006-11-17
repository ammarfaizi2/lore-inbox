Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755723AbWKQPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723AbWKQPWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbWKQPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:22:32 -0500
Received: from tim.rpsys.net ([194.106.48.114]:53175 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1755722AbWKQPWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:22:31 -0500
Subject: Re: [PATCH] usb: generic calibration support
From: Richard Purdie <rpurdie@rpsys.net>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>, daniel.ritz@gmx.ch,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200611171553.38164.hs4233@mail.mn-solutions.de>
References: <200611161125.38901.hs4233@mail.mn-solutions.de>
	 <200611170912.29317.hs4233@mail.mn-solutions.de>
	 <d120d5000611170616m73268428me0840444bca73dff@mail.gmail.com>
	 <200611171553.38164.hs4233@mail.mn-solutions.de>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 15:22:06 +0000
Message-Id: <1163776926.5551.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 15:53 +0100, Holger Schurig wrote:
> > I believe tslib handles this.
> 
> The special X server "KDrive" supports tslib, this is used in 
> many embedded projects, e.g. by images created via 
> http://www.openembedded.org. But mainline X.org server, e.g. 
> what is in Debian unstable (7.1.0), doesn't support tslib.

Someone should add tslib support to the main xorg server then ;-). All
tslib supported devices will then just work...

> Also I don't know if X/tslib allows re-calibration on-the-fly, 
> but I guess it does. 

It does.

> However, tslib usually does not work via 
> the input subsystem (/dev/input/eventX is just one of them), 
> most devices use proprietary kernel interfaces.

tslib does work via the input subsystem for almost every 2.6 kernel
based device I can think of in OpenEmbedded and we made an active effort
to get into that position. The only proprietary interfaces are old 2.4
kernels.

> Qt/Embedded for Qt 2 and Qt 3 doesn't handle tslib 
> out-of-the-box, (heck, the don't even know 
> about /dev/input/eventX), but patches exist.

Qt/E 2/3 have a ton of other input issues beside this (e.e keymap
problems) so the lack of merged tslib support is only a minor one and as
you say, patches exist.

IMO, calibration in the kernel would be a backwards step (especially
when tslib can do more besides like filtering and hopefully in the
future rescaling).

Regards,

Richard

