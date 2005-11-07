Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVKGKo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVKGKo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVKGKo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:44:28 -0500
Received: from tim.rpsys.net ([194.106.48.114]:5573 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751299AbVKGKo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:44:27 -0500
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: David Vrabel <dvrabel@cantab.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, dkrivoschokov@dev.rtsoft.ru
In-Reply-To: <436F2BB2.3040008@cantab.net>
References: <20051103221402.GA28206@elf.ucw.cz>
	 <1131057308.8523.92.camel@localhost.localdomain>
	 <20051106204506.GH29901@elf.ucw.cz>  <436F2BB2.3040008@cantab.net>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 10:43:52 +0000
Message-Id: <1131360232.8375.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 10:25 +0000, David Vrabel wrote:
> Pavel Machek wrote:
> > 
> > ...for the spitz. Do you think I can just copy this one? ...eh, no,
> > will not fly, there's no SPITZ_GPIO_USB_PULLUP.
> 
> There are internal pull-ups (and pull-downs) perhaps you can use those?
> 
> Hmmm. Though the C5 stepping might be different -- best to check the
> "specification update".

I can confirm that you'll need to use the internal pxa27x pullups for
this. You'll probably also need to make sure GPIO 35 is low to ensure
the usb Vcc line isn't powered (as it would be in usb host mode.

Ultimately, it would be nice to have the Zaurus detect whether a usb
host or client was present (using gpio 41 maybe?) and then activate the
host (ohci) or client (pxa27x_udc) driver as appropriate.

Cheers,

Richard



