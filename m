Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVJLVK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVJLVK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVJLVK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:10:56 -0400
Received: from sccrmhc12.comcast.net ([63.240.76.22]:38585 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964813AbVJLVKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:10:55 -0400
From: kernel-stuff@comcast.net
To: Christian Krause <chkr@plauener.de>, linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
Date: Wed, 12 Oct 2005 21:10:53 +0000
Message-Id: <101220052110.3094.434D7BDD0001F67000000C1622007621949D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Re-calculation in usb_fill_int_urb makes more sense, because it is the
> most general approach. So it would make sense to remove it from
> hid-core.c.
> 

Patch looks correct to me from a purely logical perspective. (IOW I read that file first time :)

But since interval is passed as a parameter to the usb_fill_int_urb() function,  I think it is more natural to remove the recalculation from usb_fill_int_urb() - If caller passes a parameter and has enough info to determine its value, it makes sense for the caller to pass in the right value and the callee to just take it as it is.

Not a big deal anyway though. 

Parag  



