Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVBQGRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVBQGRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVBQGRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:17:33 -0500
Received: from mail.tyan.com ([66.122.195.4]:9490 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262195AbVBQGRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:17:31 -0500
Message-ID: <3174569B9743D511922F00A0C943142308085989@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: YhLu <YhLu@tyan.com>, Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: node_to_cpumask  x86_64 broken
Date: Wed, 16 Feb 2005 22:30:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

forget about it. I found the reason:  I only put node 0 has RAM installed.

YH 

> -----Original Message-----
> From: YhLu 
> Sent: Wednesday, February 16, 2005 9:40 PM
> To: Andi Kleen
> Cc: linux-kernel@vger.kernel.org
> Subject: node_to_cpumask x86_64 broken
> 
> I add some printk in k8_bus.c
> 
> node id = 0, node_to_cpumask = f
> i= 0 ldtbus = 0
> i= 1 ldtbus = 40100
> i= 2 ldtbus = 0
> node id = 1, node_to_cpumask = 0
> i= 0 ldtbus = 0
> i= 1 ldtbus = 0
> i= 2 ldtbus = 70500
> node id = 2, node_to_cpumask = 0
> i= 0 ldtbus = 0
> i= 1 ldtbus = 0
> i= 2 ldtbus = 0
> node id = 3, node_to_cpumask = 0
> i= 0 ldtbus = 0
> i= 1 ldtbus = 0
> i= 2 ldtbus = 0
> k8-bus.c: bus 5 has empty cpu mask
> k8-bus.c: bus 6 has empty cpu mask
> k8-bus.c: bus 7 has empty cpu mask
> 
> it seems node_to_cpu_mask broken.
> 
> I'm using 2.6.11-RC4.
> 
> YH
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
