Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293085AbSB1XnG>; Thu, 28 Feb 2002 18:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310198AbSB1Xk7>; Thu, 28 Feb 2002 18:40:59 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:61678 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S310200AbSB1Xia>; Thu, 28 Feb 2002 18:38:30 -0500
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C1453@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'David S. Miller'" <davem@redhat.com>,
        "Leech, Christopher" <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: RE: hardware VLAN acceleration
Date: Thu, 28 Feb 2002 15:38:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Any time VLAN groups exist, the VLAN module should not be unloadable.
> 
> This is a hokey area of how the VLAN layer works and I intend
> to fix it.

OK.  I was just trying really hard to find potential API problems earlier
rather than later, obviously without taking the time to completely
understand the VLAN layer internals :)

I don't see why it wouldn't be desirable to have a method of stopping the
driver from continuing to call vlan_hwaccel_rx, so that the vlan_group could
be freed after all the VIDs were removed.  It could be as simple as
declaring that dev->vlan_rx_register(dev, NULL) is valid.

	Chris
