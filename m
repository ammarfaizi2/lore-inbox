Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319370AbSIKWer>; Wed, 11 Sep 2002 18:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319371AbSIKWer>; Wed, 11 Sep 2002 18:34:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12215 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319370AbSIKWeq>;
	Wed, 11 Sep 2002 18:34:46 -0400
Date: Wed, 11 Sep 2002 15:31:32 -0700 (PDT)
Message-Id: <20020911.153132.63843642.davem@redhat.com>
To: sim@erik.ca
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: 802.1q + device removal causing hang
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020911223252.GA12517@erik.ca>
References: <20020911223252.GA12517@erik.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try this:

--- net/8021q/vlan.c.~1~	Wed Sep 11 15:34:49 2002
+++ net/8021q/vlan.c	Wed Sep 11 15:34:59 2002
@@ -626,7 +626,7 @@
 			ret = unregister_vlan_dev(dev,
 						  VLAN_DEV_INFO(vlandev)->vlan_id);
 
-			unregister_netdev(vlandev);
+			unregister_netdevice(vlandev);
 
 			/* Group was destroyed? */
 			if (ret == 1)
