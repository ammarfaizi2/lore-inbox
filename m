Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVBKPvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVBKPvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 10:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVBKPvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 10:51:12 -0500
Received: from bay16-f19.bay16.hotmail.com ([65.54.186.69]:2098 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262260AbVBKPvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 10:51:02 -0500
Message-ID: <BAY16-F19F98BAFC5D2AFD6CC88DB87770@phx.gbl>
X-Originating-IP: [24.128.160.147]
X-Originating-Email: [n1gp@hotmail.com]
From: "Richard Koch" <n1gp@hotmail.com>
To: vojtech@suse.cz
Cc: vojtech@suse.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding the ICS MK712 touchscreen driver to 2.6
Date: Fri, 11 Feb 2005 10:50:19 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 11 Feb 2005 15:51:01.0295 (UTC) FILETIME=[7C40E3F0:01C51051]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Thanks for the evtest.c program and the information about evtouch. After the
minor change from LONG(BTN_LEFT) to LONG(BTN_TOUCH), patch below, I
was able to then get touch on/off events. Also I tested this driver with the
"evtouch" Xwindows driver and it worked nicely.

Thanks,
Rick Koch

================== PATCH START ===================

--- linux-2.6.10.nopatches/drivers/input/touchscreen/mk712.c	2005-02-11 
10:36:36.000000000 -0500
+++ linux-2.6.10/drivers/input/touchscreen/mk712.c	2005-02-11 
10:34:33.000000000 -0500
@@ -161,7 +161,7 @@ static void mk712_close(struct input_dev

static struct input_dev mk712_dev = {
	.evbit   = { BIT(EV_KEY) | BIT(EV_ABS) },
-	.keybit  = { [LONG(BTN_LEFT)] = BIT(BTN_TOUCH) },
+	.keybit  = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
	.absbit  = { BIT(ABS_X) | BIT(ABS_Y) },
	.open    = mk712_open,
	.close   = mk712_close,

===================PATCH END====================

> > >From: Vojtech Pavlik > >To: Dmitry Torokhov > >CC: 
>linux-input@atrey.karlin.mff.cuni.cz,Richard Koch , > 
> >linux-kernel@vger.kernel.org > >Subject: Re: [PATCH] adding the ICS MK712 
>touchscreen driver to 2.6 > >Date: Sun, 6 Feb 2005 10:25:33 +0100 > > > >On 
>Sat, Feb 05, 2005 at 06:00:33PM -0500, Dmitry Torokhov wrote: > > > >> > I 
>converted it to a proper input driver for you. ;) Can you check it > >if it 
>still works?
>
>--
>Vojtech Pavlik SuSE Labs, SuSE CR


