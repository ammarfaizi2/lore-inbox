Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVKBIfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVKBIfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVKBIfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:35:50 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:18856 "HELO cstnet.cn")
	by vger.kernel.org with SMTP id S932654AbVKBIft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:35:49 -0500
X-Originating-IP: [159.226.10.6]
Message-ID: <01bd01c5df88$4d6d9260$060ae29f@javaboy>
From: "jywang" <jywang@cnic.cn>
To: <linux-kernel@vger.kernel.org>
Subject: how to replace a skb within NF_IP_LOCAL_OUT hook
Date: Wed, 2 Nov 2005 16:34:55 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all
i do it as below.

 cp = skb_copy_expand(*skb, skb_headroom(*skb)+12, skb_tailroom(*skb),
GFP_ATOMIC);
 cp->csum = (*skb)->csum;
 skb_set_owner_w(cp, (*skb)->sk);
 *skb = cp;
 return NF_ACCEPT;

but it can't work perfectly.

How?




