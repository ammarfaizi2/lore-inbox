Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTLWTsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTLWTsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:48:41 -0500
Received: from web60508.mail.yahoo.com ([216.109.116.129]:6515 "HELO
	web60508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261881AbTLWTsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:48:38 -0500
Message-ID: <20031223194838.17465.qmail@web60508.mail.yahoo.com>
Date: Tue, 23 Dec 2003 11:48:38 -0800 (PST)
From: Raj Mansa <mansa_dev@yahoo.com>
Subject: bridge netfilter question
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
can someone help me and explain what this block of
code does exactly in the bridge code?

(This block is taken from br_dev_queue_xmit() @
br_forward.c, after applying 'netfilter' patch)
2.4.21 kernel

#ifdef CONFIG_NETFILTER
	if (skb->nf_bridge)
		memcpy(skb->data - 16, skb->nf_bridge->hh, 16);
#endif

1. What is 16 bytes here...? Ethernet hdr is 14 bytes
2. Why the ethernet hdr .. is being overwritten with
nf_bridge->hh? what is there in nf_bridge->hh?
3. If I remember correctly 'if' <condition> Fails for
ARP protocol

I wud appreciate if someone can help me.

-Raj

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
