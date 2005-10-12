Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVJLXcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVJLXcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVJLXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:32:55 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:46077 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932430AbVJLXcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:32:54 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Christian Krause <chkr@plauener.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
Date: Wed, 12 Oct 2005 23:32:50 +0000
Message-Id: <101220052332.3804.434D9D220007875C00000EDC220588644200009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Yes, but in this case we have to check all callers of usb_fill_int_urb
> to do the recalculation. E.g. in input/usbmouse.c
> endpoint->bInterval is used directly as parameter to usb_fill_int_urb.

Absolutely correct - There are 41 callers per LXR in 2.6.11 - may be even more in the current kernel.

> 
> To avoid breaking things (my suggested patch has no impact on any other
> usb driver) and to solve the problem shortly, I suggest to
> use my patch and do some kind of refactoring later (You are right,
> for a clean interface the interval parameter should have the same
> meaning independend of the speed).
> 
> 

Agreed. Looking at some of the callers, it will take some time and refactoring to fix all of them. For now, it makes sense to put your patch in if no one has an objection.

Thanks

Parag



