Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265630AbUAPSZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUAPSZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:25:14 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:59866 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S265630AbUAPSZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:25:10 -0500
Message-ID: <005101c3dc5e$1aac93a0$0e25fe96@southpark.ae.poznan.pl>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet> <000b01c3dc46$44cc3180$0e25fe96@southpark.ae.poznan.pl> <001701c3dc48$d05763d0$0e25fe96@southpark.ae.poznan.pl> <20040116181429.GK1748@srv-lnx2600.matchmail.com>
Subject: Re: [PATCH 2.6 FIXED] Re: Linux 2.4.25-pre6
Date: Fri, 16 Jan 2004 19:25:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it did wrap, thanks Mike.
This one should be fine.

Maciej

--- icmp.c~ 2003-12-18 03:59:40.000000000 +0100
+++ icmp.c 2004-01-16 16:47:28.000000000 +0100
@@ -670,7 +670,7 @@
    printk(KERN_WARNING "%u.%u.%u.%u sent an invalid ICMP "
           "type %u, code %u "
           "error to a broadcast: %u.%u.%u.%u on %s\n",
-          NIPQUAD(skb->nh.iph->saddr),
+          NIPQUAD(iph->saddr),
           icmph->type, icmph->code,
           NIPQUAD(iph->daddr),
           skb->dev->name);

