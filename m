Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293513AbSB1WCI>; Thu, 28 Feb 2002 17:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292934AbSB1WAJ>; Thu, 28 Feb 2002 17:00:09 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:13296 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S310135AbSB1V5J>; Thu, 28 Feb 2002 16:57:09 -0500
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C144F@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: RE: [BETA-0.92] Third test release of Tigon3 driver
Date: Thu, 28 Feb 2002 13:57:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> e1000 has a VLAN filter type on-chip, which complicates things a tiny bit.

The filtering is separate from the tagging.  Filtering lets the hardware
ignore tagged packets for VLANs that it's not a member of.  The vlan_group
structure isn't well laid out for this, but it would be possible to search
for non-NULL values in the vlan_devices array to get the VLAN IDs for
filtering.  The driver would need to know when new VLAN IDs were added to
the group.

	Chris

--
Chris Leech <christopher.leech@intel.com>
Network Software Engineer
UNIX/Linux/Netware Development Group
LAN Access Division, Intel
