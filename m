Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754662AbWKHVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbWKHVuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbWKHVuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:50:18 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:14573 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1754662AbWKHVuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:50:17 -0500
Message-ID: <45524E3A.7080301@soleranetworks.com>
Date: Wed, 08 Nov 2006 14:38:02 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: e1000 driver 2.6.18 - how to waste processor cycles
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a good reason the skb refill routine in e1000_alloc_rx_buffers 
needs to go and touch and remap skb memory
on already loaded descriptors/  This seems extremely wasteful of 
processor cycles when refilling the ring buffer.

I note that the archtiecture has changed and is recycling buffers from 
the rx_irq routine and when the routine is called
to refill the ring buffers, a lot of wasteful and needless calls for 
map_skb is occurring.

Jeff
