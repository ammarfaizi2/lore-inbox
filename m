Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTEOCw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTEOCw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:52:56 -0400
Received: from rth.ninka.net ([216.101.162.244]:1774 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263763AbTEOCwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:52:55 -0400
Subject: Re: [PATCH] fix kernel link error with 2.4.21rc2ac2 using gcc 3.3
From: "David S. Miller" <davem@redhat.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030514213554.52466.qmail@web40503.mail.yahoo.com>
References: <20030514213554.52466.qmail@web40503.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052967943.19682.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 20:05:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 14:35, Alex Davis wrote:
> -extern __inline__ int rtnetlink_rcv_skb(struct sk_buff *skb)
> +extern int rtnetlink_rcv_skb(struct sk_buff *skb)

Fix is wrong, mark it static instead.  That's what I'm
doing in my tree.

-- 
David S. Miller <davem@redhat.com>
