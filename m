Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbULWQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbULWQuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbULWQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 11:50:40 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:47775 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261197AbULWQuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 11:50:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=FlYIR2HeUBf0BvEiQ8IUNDD+yaVKOEwDEeJNV0F//2VGHl85eUqK1+rKeRO5CBwYaUjjAwan6JHIblSnh4ngcZi525uHpOvhVV9z8ljZOX1LXY+hSwg+pI3LkmSjrXpzFMYvzg9U6ppvs2HjDNaGBQfm7PzHGZT3FT9FmUJzh6w=
Message-ID: <72c6e37904122308501b0f689a@mail.gmail.com>
Date: Thu, 23 Dec 2004 22:20:36 +0530
From: linux lover <linux.lover2004@gmail.com>
Reply-To: linux lover <linux.lover2004@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what is use of dev_queue_xmit_nit?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
      I want to know what is use of dev_queue_xmit_nit function in
dev.c file? Also why it calls following statement
                       ptype->func(skb2, skb->dev, ptype);
Also why skb2 is created by cloning skb? Acually i trace TCP packets
and found that control goes from neigh_resolve_output to directly
dev_queue_xmit_nit and then to HW driver 8139too.c? I want to know why
it not goes from dev_queue_xmit? I place printk statments and found
after dev_queue_xmit_nit control moves to network interface driver?
Help to understand the control  packet path.
Thanks in advance.
linux_lover
