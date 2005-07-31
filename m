Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVGaC2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVGaC2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVGaC2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:28:41 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:63975
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S261538AbVGaC2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:28:40 -0400
Date: Sat, 30 Jul 2005 19:24:22 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, hostap@shmoo.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] include/net/ieee80211.h must #include <linux/wireless.h>
Message-ID: <20050731022422.GH8195@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, hostap@shmoo.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050727195100.GA29092@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727195100.GA29092@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 09:51:00PM +0200, Adrian Bunk wrote:

> gcc found an (although perhaps harmless) bug:
> 
>   CC      net/ieee80211/ieee80211_crypt.o
> In file included from net/ieee80211/ieee80211_crypt.c:21:
> include/net/ieee80211.h:26:5: warning: "WIRELESS_EXT" is not defined

> +++ linux-2.6.13-rc3-mm1-full/include/net/ieee80211.h	2005-07-22 18:38:10.000000000 +0200
> +#include <linux/wireless.h>

>  #if WIRELESS_EXT < 17
>  #define IW_QUAL_QUAL_INVALID   0x10

Wouldn't the proper fix be to just remove this backwards compatibility
code since WIRELESS_EXT is actually 18 in this tree anyway.. Is there
valid need to keep this header file compatible with older kernel
versions?

-- 
Jouni Malinen                                            PGP id EFC895FA
