Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266419AbUAIGiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 01:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266418AbUAIGiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 01:38:13 -0500
Received: from mailint.compaq.com ([161.114.1.205]:51466 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266415AbUAIGiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 01:38:08 -0500
Message-ID: <3FFE4D23.5030400@toughguy.net>
Date: Fri, 09 Jan 2004 12:11:39 +0530
From: Raj <obelix123@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joilnen Leite <pidhash@yahoo.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: about ipmr
References: <20040109053433.3812.qmail@web12609.mail.yahoo.com>
In-Reply-To: <20040109053433.3812.qmail@web12609.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------020600050404070001010704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600050404070001010704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I would prefer this way of checking the NULL

That would be more consistent with ip_gre.c and ipip.c

any suggestions ?

/Raj


--------------020600050404070001010704
Content-Type: text/plain;
 name="ipmr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmr.patch"

--- ipmr.c.org	2004-01-09 12:07:45.271713432 +0530
+++ ipmr.c	2004-01-09 12:09:39.389364912 +0530
@@ -205,6 +205,9 @@ static struct net_device *ipmr_reg_vif(v
 	dev = alloc_netdev(sizeof(struct net_device_stats), "pimreg",
 			   reg_vif_setup);
 
+	if( dev == NULL)
+		return NULL;
+
 	if (register_netdevice(dev)) {
 		kfree(dev);
 		return NULL;

--------------020600050404070001010704--

