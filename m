Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVJSStn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVJSStn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVJSStn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:49:43 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:28107 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751218AbVJSStm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:49:42 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed, 19 Oct 2005 20:49:36 +0200
In-reply-to: <43565257.6020505@ens-lyon.fr>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Wifi oddness [Was: Re: 2.6.14-rc4-mm1]
References: <20051016154108.25735ee3.akpm@osdl.org>
Message-Id: <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've been having problems with ipw2200 oopsing at modprobe since
>2.6.14-rc2-mm1 (sorry for not reporting before). I use the ipw2200
>included in the kernel.

Can you apply this and tell me what are the numbers?

--- d/net/ieee80211/ieee80211_wx.c	2005-10-19 20:40:52.000000000 +0200
+++ d/net/ieee80211/ieee80211_wx.c.new	2005-10-19 20:44:00.000000000 +0200
@@ -152,6 +152,8 @@
 		iwe.u.qual.level = 0;
 	} else {
 		iwe.u.qual.level = network->stats.rssi;
+		printk(KERN_ERR "---THIS: %d, %d\n", ieee->perfect_rssi,
+			ieee->worst_rssi);
 		iwe.u.qual.qual =
 		    (100 *
 		     (ieee->perfect_rssi - ieee->worst_rssi) *
