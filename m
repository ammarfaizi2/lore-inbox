Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293718AbSB1XWr>; Thu, 28 Feb 2002 18:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310196AbSB1XUY>; Thu, 28 Feb 2002 18:20:24 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:48093 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S310185AbSB1XSA>; Thu, 28 Feb 2002 18:18:00 -0500
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C1452@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'David S. Miller'" <davem@redhat.com>,
        "Leech, Christopher" <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: RE: hardware VLAN acceleration
Date: Thu, 28 Feb 2002 15:17:54 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   
> The group is still valid, groups are never destroyed by the VLAN layer
> once they are created.

Unless the 802.1q code is built as a module.  It looks to me like if you
unregistered the virtual interface and unload the 802.1q module, if another
tagged packet is received tg3 will still call vlan_hwaccel_rx and deref
tp->vlgrp which now points to who knows what.

	Chris

--
Chris Leech <christopher.leech@intel.com>
Network Software Engineer
UNIX/Linux/Netware Development Group
LAN Access Division, Intel
