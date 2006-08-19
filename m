Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWHTPiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWHTPiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWHTPiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:38:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13268 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750826AbWHTPiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:38:16 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [04/13]: zero copy write 1 of 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <f262a8dec6bec42dce9e5723ff332f5d@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <f262a8dec6bec42dce9e5723ff332f5d@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Aug 2006 11:18:12 +0100
Message-Id: <1155982692.4051.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

> +	skb->len = sizeof *h + sizeof *ah;
> +	memset(h, 0, skb->len);

Never play with skb->len directly. Use skb_put/skb_trim


