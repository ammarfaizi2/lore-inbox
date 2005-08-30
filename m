Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVH3Crm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVH3Crm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 22:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVH3Crm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 22:47:42 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:56549 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932096AbVH3Crl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 22:47:41 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=Xk5bk3bxJLOKF13SkGej++Oaw89maia9YrW4M+lKMDkouD6qleGWuMMA7oCbDdEdH
	KMZapjbfHgVUhl7hi8+1g==
Date: Mon, 29 Aug 2005 19:47:37 -0700
From: David Brownell <david-b@pacbell.net>
To: lutchann@litech.org, linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: [PATCH 0/5] improve i2c probing
References: <20050820233348.40226.qmail@web30311.mail.mud.yahoo.com>
In-Reply-To: <20050820233348.40226.qmail@web30311.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050830024737.09FACBFE34@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 21 Aug 2005 00:33:48 +0100 (BST)
> From: Mark Underwood <basicmark@yahoo.com>
>
> ...
> Interestingly (we for me at least ;-) I have been
> working on an SPI subsystem that was/is a copy of the
> I2C subsystem with changes as SPI doesn't have a
> protocol like I2C. ...
>
> To me, what I have, like I2C, doesn't tie in very well
> with the new driver model (although I'm not overly
> familiar with it, I think I finally understand
> platform devices :-).

Yes, it takes maybe a little while to sort out what the
driver model does for you, especially if you're coming
from whatever strange dimension the I2C model did.  :)


> I wonder how much work the new kernel subsystems can
> do for us to cut down the size of i2c-core (and thus
> also spi-core).
> I guess there is no escaping the fact that I'm going
> to gave to do some more homework and study the code.
> Any thoughts or insights would be very welcome.

Well, I've just posted a sketch of how to use the driver
model in a more traditional way for SPI.  That same
approach could be taken with I2C if/when anyone gets
motivated to make it happen ... except that, unlike SPI,
I2C can actually use hardware probing in common usage.
(It could kick in right after the pre-declared devices
Get initialized.)

- Dave

