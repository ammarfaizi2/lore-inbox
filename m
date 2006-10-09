Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWJIDm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWJIDm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWJIDm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:42:29 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:40547 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751619AbWJIDm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:42:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAKphKUWBTg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [linux-usb-devel] [PATCH] usb/hid: The HID Simple =?iso-8859-1?q?Driver=09Interface_0=2E3=2E2?= (core)
Date: Sun, 8 Oct 2006 23:42:25 -0400
User-Agent: KMail/1.9.3
Cc: "raise.sail@gmail.com" <raise.sail@gmail.com>, greg <greg@kroah.com>,
       Randy Dunlap <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
References: <200609291624123283320@gmail.com> <45286B85.90402@gmail.com> <452948AD.8030600@gmail.com>
In-Reply-To: <452948AD.8030600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610082342.26110.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 October 2006 14:51, Anssi Hannula wrote:
> (I didn't get Dmitry's original mail, so replying here)
> 
> raise.sail@gmail.com wrote:
> > Dmitry Torokhov wrote:
> >> Then there is issue with automatic loading of these sub-drivers. How
> >> do they get loaded? Or we force everything to be built-in making HID
> >> module very fat (like psmouse got pretty fat, but with HID prtential
> >> for it to get very fat is much bigger).
> >>
> >> The better way would be to split hid-input into a library module that
> >> parses hid usages and reports and is shared between device-specific
> >> modules that are "real" drivers (usb-drivers, not hid-sub-drivers).
> 
> One possibility is to do that with symbol_request() and friends. That
> would not be pretty though, imho.
> 
> DVB subsystem uses that currently to load frontend modules dynamically,
> see dvb_attach() and dvb_frontend_detach() in
> drivers/media/dvb/dvb-core/dvbdev.h and
> drivers/media/dvb/dvb-core/dvb_frontend.c.
> 

Unfortunately this does not quite work when hid is built-in and the rest
are modules :(

-- 
Dmitry
