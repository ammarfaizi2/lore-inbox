Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVF1J2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVF1J2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVF1J1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:27:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16594
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262023AbVF1J0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:26:22 -0400
Date: Tue, 28 Jun 2005 02:26:04 -0700 (PDT)
Message-Id: <20050628.022604.02288401.davem@davemloft.net>
To: dcb314@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: variable used before it is set
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <BAY19-F15587C5037C178B447330E9CE10@phx.gbl>
References: <BAY19-F15587C5037C178B447330E9CE10@phx.gbl>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "d binderman" <dcb314@hotmail.com>
Date: Tue, 28 Jun 2005 09:16:56 +0000

> net/bridge/netfilter/ebt_log.c(91): remark #592: variable "u" is used before 
> its value is set
>         printk(" IP tos=0x%02X, IP proto=%d", u.iph.tos,
>                                               ^
> I agree with the compiler. Suggest code rework.

I added this bug, I'll fix it.  It should use iph->tos
instead, and the entire 'u' array on the local stack
removed since there are then no more users of it.
