Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWC0Ki1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWC0Ki1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWC0Ki1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:38:27 -0500
Received: from smtp2.home.se ([212.78.199.22]:15510 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id S1750874AbWC0Ki1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:38:27 -0500
Date: Mon, 27 Mar 2006 12:37:57 +0200
From: Martin Samuelsson <sam@home.se>
To: linux-kernel@vger.kernel.org
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: AverMedia 6 Eyes AVS6EYES driver
Message-Id: <20060327123757.6e06cf8a.sam@home.se>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again!

This time, I bring you a somewhat larger patch than the previous one. It adds support for the AverMedia AVS6EYES Zoran-based MJPEG card. And it's not base64 encoded. Sorry about that one.

It can be found at 

http://sam.kfib.org/sixeyes/linux-2.6.16-avs6eyes.diff

and weighs in at a respectable 46 kB.

I've tried to keep it as small as possible, but it does affect quite a number of things:

It adds a whole new driver, for the Conexant bt866 video encoder.
It imports an almost whole new driver, created within the Marvel project, for the Samsung ks0127 video decoder.
It modifies drivers/media/video/Kconfig,
            drivers/media/video/Makefile,
            drivers/media/video/zoran_card.c,
            drivers/media/video/zoran.h,
            Documentation/video4linux/Zoran
        and include/linux/i2c-id.h

The latter defines two experimental I2C_DRIVERIDs; not suited for real usage, but I'm not sure about how to obtain official ones.

I've stripped the ks0127 driver of all Marvel specific stuff, and reworked a few crucial functions to use stock kernel names for video modes and such things.

The diff is against the 2.6.16 tree, and considering its size and impact, it would probably be wise to let somebody with a little spare time take a look at it before inclusion.

I'd appreciate being kept in the recipient list in case of discussion.

Regards,
/Sam
