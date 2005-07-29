Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVG2Hqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVG2Hqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVG2HoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:44:22 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10176 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262482AbVG2Hm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:42:58 -0400
Date: Fri, 29 Jul 2005 09:42:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexander Trotsai <mage@adamant.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: routing/shaping vs smp
In-Reply-To: <20050728161317.GE3990@blackhole.adamant.ua>
Message-ID: <Pine.LNX.4.61.0507290941330.26861@yvahk01.tjqt.qr>
References: <20050728161317.GE3990@blackhole.adamant.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi
>
>Is that possible use power of 2 or more CPU (smp) for
>routing/shaping/accounting (iptables rules) with 2.4.x or
>may be 2.6.x linux kernel?

Incoming packets are handled in an interrupt. So if you can manage to 
distribute IRQs between CPUs, you can at least split the routing work
per NIC, e.g. cpu0 for eth0, cpu1 for eth1.


Jan Engelhardt
-- 
