Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTLXOqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 09:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTLXOqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 09:46:03 -0500
Received: from web60507.mail.yahoo.com ([216.109.116.128]:40342 "HELO
	web60507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263632AbTLXOqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 09:46:01 -0500
Message-ID: <20031224144601.61887.qmail@web60507.mail.yahoo.com>
Date: Wed, 24 Dec 2003 06:46:01 -0800 (PST)
From: Raj Mansa <mansa_dev@yahoo.com>
Subject: Netfilter 2.4.21 Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found this block of code in br_dev_queue_xmit() @
br_forward.c, after applying 'netfilter' patch for
2.4.21 kernel

Can someone explain what this block of code is doin?

#ifdef CONFIG_NETFILTER
        if (skb->nf_bridge)
                memcpy(skb->data - 16,
skb->nf_bridge->hh, 16);
#endif

1. What is 16 bytes here...? Ethernet hdr is just 14
bytes
2. Why the ethernet hdr is being overwritten with
nf_bridge->hh? what is there in nf_bridge->hh? and
when is nf_bridge being assigned this content.
3. If I remember correctly 'if' <condition> Fails for
ARP protocol and arp is untouched.

-Raj

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
