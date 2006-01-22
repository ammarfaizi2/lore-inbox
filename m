Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWAVNdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAVNdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 08:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWAVNdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 08:33:04 -0500
Received: from stinky.trash.net ([213.144.137.162]:62388 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751207AbWAVNdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 08:33:02 -0500
Message-ID: <43D38953.7040100@trash.net>
Date: Sun, 22 Jan 2006 14:32:03 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
Subject: Re: [PATCH] ieee80211_rx_any: filter out packets, call ieee80211_rx
 or ieee80211_rx_mgt
References: <20060118200616.GC6583@tuxdriver.com> <200601221404.52757.vda@ilport.com.ua>
In-Reply-To: <200601221404.52757.vda@ilport.com.ua>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> bcm43xx_rx() contains code to filter out packets from
> foreign BSSes and decide whether to call ieee80211_rx
> or ieee80211_rx_mgt. This is not bcm specific.
> 
> +/* Kernel doesn't have it, why? */
> +static inline int is_mcast_or_bcast_ether_addr(const u8 *addr)
> +{
> +        return (0x01 & addr[0]);
> +}

The same function exists in include/linux/etherdevice.h:

static inline int is_multicast_ether_addr(const u8 *addr)
{
        return (0x01 & addr[0]);
}
