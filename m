Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266607AbUFWSqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUFWSqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266606AbUFWSqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:46:00 -0400
Received: from mail.njit.edu ([128.235.251.173]:6858 "EHLO mail-gw5.njit.edu")
	by vger.kernel.org with ESMTP id S266605AbUFWSpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:45:51 -0400
Date: Wed, 23 Jun 2004 14:45:47 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: Question about ip_rcv() function
In-Reply-To: <20040622212403.21346.qmail@lwn.net>
Message-ID: <Pine.GSO.4.58.0406231441500.7099@chrome.njit.edu>
References: <20040622212403.21346.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can anyone explain what is the difference between the following two pieces
of code.

1. if (!pskb_may_pull(skb, sizeof(struct iphdr)))
                goto inhdr_error;

   iph = skb->nh.iph;

2. if (!pskb_may_pull(skb, iph->ihl*4))
                goto inhdr_error;

   iph = skb->nh.iph;


Also, does anyone know how the headers are stripped from the packet at the
receiving end. Does the function __pskb_pull_tail() strip of the header fields ?

Thanks,
Rahul.
