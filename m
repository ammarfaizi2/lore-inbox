Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310240AbSCAABI>; Thu, 28 Feb 2002 19:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293486AbSB1X7V>; Thu, 28 Feb 2002 18:59:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10368 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310217AbSB1XyR>;
	Thu, 28 Feb 2002 18:54:17 -0500
Date: Thu, 28 Feb 2002 15:52:12 -0800 (PST)
Message-Id: <20020228.155212.41634104.davem@redhat.com>
To: christopher.leech@intel.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hardware VLAN acceleration
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1453@orsmsx118.jf.intel.com>
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C1453@orsmsx118.jf.intel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Leech, Christopher" <christopher.leech@intel.com>
   Date: Thu, 28 Feb 2002 15:38:24 -0800
   
   I don't see why it wouldn't be desirable to have a method of stopping the
   driver from continuing to call vlan_hwaccel_rx, so that the vlan_group could
   be freed after all the VIDs were removed.  It could be as simple as
   declaring that dev->vlan_rx_register(dev, NULL) is valid.

This is how I intended it to be used.  It isn't done now only because
this event does not occur within the VLAN layer :)
