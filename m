Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424120AbWKPO5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424120AbWKPO5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424122AbWKPO5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:57:30 -0500
Received: from legolas.otaku42.de ([217.24.0.78]:54402 "EHLO
	legolas.otaku42.de") by vger.kernel.org with ESMTP id S1424120AbWKPO53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:57:29 -0500
Message-ID: <4250.194.45.26.221.1163689011.squirrel@webmail.otaku42.de>
In-Reply-To: <455C731A.4010503@scram.de>
References: <20061115031025.GH3451@tuxdriver.com>
    <200611151942.14596.mb@bu3sch.de>
    <20061115192054.GA10009@tuxdriver.com>
    <200611152026.26095.mb@bu3sch.de> <455C731A.4010503@scram.de>
Date: Thu, 16 Nov 2006 15:56:51 +0100 (CET)
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assess ar5k 
     (enabling free Atheros HAL)
From: "Michael Renzmann" <madwifi@nospam.otaku42.de>
To: "Jochen Friedrich" <jochen@scram.de>
Cc: "Michael Buesch" <mb@bu3sch.de>, madwifi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       lwn@lwn.net
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> At least, this way we have a chance to get USB working as well (See
> http://madwifi.org/ticket/33).

It's not the HAL that prevents MadWifi implementing USB support. Replacing
the binary-only HAL with OpenHAL and/or dissolving the HAL functionality
in the driver source does not get us any closer to a working support of
USB sticks.

Quoting Sam Leffler on that topic:

=== cut ===
The Atheros-based USB devices work rather differently from the
cardbus/pci cards.  In particular there is no hal; instead there's an
onboard processor that runs the hal and implements a special protocol.
This means you can reuse some of madwifi but you also (probably) need to
redo the code some to break out different interfaces.  It's not a simple
project.
=== cut ===

see: http://article.gmane.org/gmane.linux.drivers.madwifi.user/5380

> OpenBSD seems to have a working driver (if_uath.c) for these USB WLAN
> sticks.

Which, at least for some sticks, requires a not freely distributable
binary firmware blob, by the way (see:
http://archives.neohapsis.com/archives/openbsd/cvs/2006-09/0233.html ).
Nevertheless, it would be nice to have that driver ported to Linux.

Bye, Mike

