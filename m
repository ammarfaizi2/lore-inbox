Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTKQV2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTKQV2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:28:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49342 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261546AbTKQV16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:27:58 -0500
Date: Mon, 17 Nov 2003 22:27:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Corrected drivermodel for i8042.c
Message-ID: <20031117212757.GA24749@atrey.karlin.mff.cuni.cz>
References: <SuZ0.4nW.7@gated-at.bofh.it> <20031117205131.GB20681@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117205131.GB20681@hell.org.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's (slightly) better patch. i8042_controller_init() can not be
> > __init when it is called from _resume() function.
> 
> Hi,
> Your patch makes my keyboard work again after S3. Yay!
> The touchpad still doesn't work, but that's expected I suppose.

Yep.

> The odd thing is, both the keyboard and the touchpad work fine if the S3
> cycle is followed by an swsusp/pmdisk one.

Its not odd at all. BIOS/linux boot does reinit at this point => linux
finds touchpad in usable state. This is exactly why swsusp is easier
than S3: if you forget to resume something, you'll usually get lucky
and it will not matter.
					Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
