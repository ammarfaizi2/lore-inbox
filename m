Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVANQo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVANQo3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVANQo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:44:29 -0500
Received: from mx1.starman.ee ([62.65.192.16]:21693 "EHLO mx1.starman.ee")
	by vger.kernel.org with ESMTP id S261830AbVANQmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:42:49 -0500
Reply-To: <jyri.poldre@artecdesign.ee>
From: "=?iso-8859-4?B?SvxyaSBQ9WxkcmU=?=" <jyri.poldre@artecdesign.ee>
To: <linux-kernel@vger.kernel.org>
Subject: Ethernet driver link state propagation to ip stack
Date: Fri, 14 Jan 2005 18:42:54 +0200
Message-ID: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-4"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I am experiencing issues with connecting two network adapters to the same
subnet, eg.

eth0 192.168.100.200
eth1 192.168.100.201

The task is to have redundant connections to two different hubs. In case one
link goes down the connection should go through the other. The driver
handles link events with netif_carrier_ok and netif_carrier_on from
linux/netdevice.h. These eventually send messages to networking stack with
netdev_change_state from net/core/dev.c

My question is:  Does the kernel handle  the interface state/routing tables
modifications due to link changing automatically or is there some external
daemon required to do that. Any links are greatly appreciated.


Sincerely,
Jyri Põldre.

