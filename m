Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310185AbSB1X1A>; Thu, 28 Feb 2002 18:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310208AbSB1XZF>; Thu, 28 Feb 2002 18:25:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36242 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310201AbSB1XWZ>;
	Thu, 28 Feb 2002 18:22:25 -0500
Date: Thu, 28 Feb 2002 15:20:03 -0800 (PST)
Message-Id: <20020228.152003.17593481.davem@redhat.com>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hardware VLAN acceleration
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1452@orsmsx118.jf.intel.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1452@orsmsx118.jf.intel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Leech, Christopher" <christopher.leech@intel.com>
   Date: Thu, 28 Feb 2002 15:17:54 -0800

      
   > The group is still valid, groups are never destroyed by the VLAN layer
   > once they are created.
   
   Unless the 802.1q code is built as a module.  It looks to me like if you
   unregistered the virtual interface and unload the 802.1q module, if another
   tagged packet is received tg3 will still call vlan_hwaccel_rx and deref
   tp->vlgrp which now points to who knows what.
   
Any time VLAN groups exist, the VLAN module should not be unloadable.

This is a hokey area of how the VLAN layer works and I intend
to fix it.
