Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266593AbUFWRmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266593AbUFWRmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFWRmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:42:42 -0400
Received: from [200.29.57.153] ([200.29.57.153]:16319 "EHLO exis.cl")
	by vger.kernel.org with ESMTP id S266593AbUFWRml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:42:41 -0400
Date: Wed, 23 Jun 2004 13:38:19 -0400
From: phill whelan <kernel@exis.cl>
To: linux-kernel@vger.kernel.org
Subject: NF_ARP_OUT skb has NULL link layer header
Message-Id: <20040623133819.571db2e7.kernel@exis.cl>
Organization: Exis
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been working lately on a netfilter hook extension which rewrites outgoing ARP packets to spoof a host's MAC address.

I've succesfully spoofed ARP replies, but have seen that several OS's tend to update their arp cache based on information in ARP requests.
After several panic()'s, I noticed that the link layer header (skb->mac)
is NULL. My intention was to rewrite the ethernet mac address to the spoofed MAC address.

Is there a way to rewrite the link layer header besides modifying skb->mac (skb->mac.ethernet to be precise), or could I possibly just tag on a kmalloc()'ed pointer to the skb->mac?

If it makes any difference, I only noticed this when porting the code to linux 2.6 (2.6.7).

Thanks a lot, in advance

Phillip Whelan
EXIS (http://www.exis.cl)
