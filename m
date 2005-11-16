Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbVKPVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVKPVCH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVKPVCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:02:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20106
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932589AbVKPVCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:02:06 -0500
Date: Wed, 16 Nov 2005 13:02:02 -0800 (PST)
Message-Id: <20051116.130202.10764437.davem@davemloft.net>
To: lvc@lucent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bugs in /usr/src/linux/net/ipv6/mcast.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <0C6AA2145B810F499C69B0947DC5078107BCDB0C@oh0012exch001p.cb.lucent.com>
References: <0C6AA2145B810F499C69B0947DC5078107BCDB0C@oh0012exch001p.cb.lucent.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
Date: Wed, 16 Nov 2005 09:53:07 -0500

> /usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 609         
>                 if (mc->sfmode == MCAST_INCLUDE && i >= psl->sl_count);
>                         rv = 0;                                        
> should be:
> 		    if (mc->sfmode == MCAST_EXCLUDE && i >= psl->sl_count)
> 				rv = 0;
> 
> /usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 611         
>                 if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count); 
>                         rv = 0;                             
> should be:
> 		    if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count)
> 				rv = 0;

These have been fixed for a while now in 2.6.x

