Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUBOTZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbUBOTZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 14:25:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1298 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265173AbUBOTZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 14:25:06 -0500
Date: Sun, 15 Feb 2004 20:19:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3: twice defined symbols with new radeonfb
In-Reply-To: <20040215132237.GS1308@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402152016190.7851@serv>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
 <20040215074106.GQ1308@fs.tum.de> <1076831240.6960.35.camel@gaston>
 <20040215132237.GS1308@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 15 Feb 2004, Adrian Bunk wrote:

> @Roman:
> With the patch below, "make menuconfig" shows
>        [ ]   ATI Radeon display support
>          [*]     ATI Radeon display support (Old driver)
>
> How can I void that the old driver is shown as if it was an option for
> the new driver?

Only if you interrupt the dependency chain (e.g. by inserting a dummy
entry).
What about making it a choice, I extended it for exactly this purpose. :)
Simply put the two options inbetween:

choice
        prompt "ATI Radeon display support"
        optional

...

endchoice

bye, Roman
