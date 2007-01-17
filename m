Return-Path: <linux-kernel-owner+w=401wt.eu-S932564AbXAQSgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXAQSgJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 13:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbXAQSgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 13:36:09 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:43652 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932564AbXAQSgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 13:36:08 -0500
Date: Wed, 17 Jan 2007 19:33:21 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix compile warnings in r8169
Message-ID: <20070117183321.GA32388@electric-eye.fr.zoreil.com>
References: <20070117141932.GA20534@strauss.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117141932.GA20534@strauss.suse.de>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Walle <bwalle@suse.de> :
> --- linux-2.6.20-rc4.orig/drivers/net/r8169.c	2007-01-07 06:45:51.000000000 +0100
> +++ linux-2.6.20-rc4/drivers/net/r8169.c	2007-01-17 11:39:13.792309228 +0100
[...]
> @@ -2227,7 +2227,7 @@ static int rtl8169_xmit_frags(struct rtl
>  {
>  	struct skb_shared_info *info = skb_shinfo(skb);
>  	unsigned int cur_frag, entry;
> -	struct TxDesc *txd;
> +	struct TxDesc *txd = NULL;
>  
>  	entry = tp->cur_tx;
>  	for (cur_frag = 0; cur_frag < info->nr_frags; cur_frag++) {

The driver is right. This change does not alleviate the maintenance
of the driver nor does it add incentive to fix the compiler.

-- 
Ueimor
