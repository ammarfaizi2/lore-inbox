Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130062AbRB1FFG>; Wed, 28 Feb 2001 00:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbRB1FE4>; Wed, 28 Feb 2001 00:04:56 -0500
Received: from linuxcare.com.au ([203.29.91.49]:18439 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130062AbRB1FEp>; Wed, 28 Feb 2001 00:04:45 -0500
Date: Wed, 28 Feb 2001 16:04:39 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: linux-kernel@vger.kernel.org
Subject: Alternative driver for Lucent 802.11 cards
Message-ID: <20010228160439.A2730@linuxcare.com>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a driver for the Lucent and Cabletron 802.11 cards, to
replace the wvlan_cs driver. I'm looking for people to test this
driver with as many card/firmware variations as possible.

The new driver doesn't use the Lucent HCF-Light code, and as a
consequence the code should be easier to follow. The locking is also
slightly more sophisticated in that this driver shouldn't leave IRQs
disabled for long periods of time like wvlan_cs can.

The driver is basically complete, although it lacks a few features of
wvlan_cs (some less used iwconfig settings). Currently it supports the
Lucent and Cabletron cards, and it partially works (no WEP) on at
least one Prism based card (the Farallon Skyline). I hope to make it
support the Apple Airport cards as well, eventually.

wvlan_cs, the linux-wlan driver and the NetBSD if_wi driver were all
used quite heavily as references in writing this driver. This driver
is written (currently) strictly for use with 2.4 - it won't work with
2.2 or with the out-of-the-kernel pcmcia modules (mostly for trivial
reasons).

Currently it's not nicely packaged. The various files can be grabbed
from:
	 http://www.linuxcare.com.au/dgibson/dldwd/
How to build and install the driver is left as an exercise to the
reader.

-- 
David Gibson, Technical Support Engineer, Linuxcare, Inc.
+61 2 6262 8990
dgibson@linuxcare.com.au http://www.linuxcare.com/ 
Linuxcare. Putting open source to work.
