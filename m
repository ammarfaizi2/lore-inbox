Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWDEPFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWDEPFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWDEPFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:05:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63884 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750872AbWDEPFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:05:21 -0400
Message-ID: <4433DCAF.5060503@garzik.org>
Date: Wed, 05 Apr 2006 11:05:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: yzy <yzy@clusterfs.com>
CC: linux-kernel@vger.kernel.org, eeb@clusterfs.com, green@clusterfs.com
Subject: Re: Here is the tcp-zero-copy patch for kernel 2.6.12-6 .
References: <44336CC0.6030206@clusterfs.com>
In-Reply-To: <44336CC0.6030206@clusterfs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.7 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.7 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yzy wrote:
> Hello linux-kernel:
> 
> I do some work on tcp-zero-copy for kernel 2.6.12-6 ( vanilla ) , Here 
> is the patch . Please review and discussion it .
> 
> The patch modify mainly these files below :
> (1) include/linux/skbuff.h : add a zccd_t struct , it include the 
> zero-copy's callback function pointer and reference count.
> (2)include/net/tcp.h : add a new function  tcp_sendpage_zccd( ) . It  
> was used as send a memory page to TCP/IP stack.
> (3)net/core/dev.c (4)net/core/skbuff.c : process the initial ,refcount 
> and release of zccd information.
> (5)net/ipv4/tcp.c : call the tcp_sendpage_zccd() function to send a 
> memory page.

1) Why, we already have zero-copy?

2) Please send to netdev@vger.kernel.org, which is where the people who 
maintain this code live.

	Jeff



