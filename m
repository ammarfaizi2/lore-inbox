Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVAWR0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVAWR0t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 12:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVAWR0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 12:26:49 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:9964 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261333AbVAWR0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 12:26:47 -0500
Date: Sun, 23 Jan 2005 12:26:47 -0500
From: sean <seandarcy@hotmail.com>
Subject: Re: Linux 2.6.11-rc2
In-reply-to: <1106440494.20995.44.camel@tux.rsn.bth.se>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <41F3DE57.3040008@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050109
 Fedora/1.7.5-3
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
 <20050121223247.65c544f8@laptop.hypervisor.org>
 <1106402669.20995.23.camel@tux.rsn.bth.se> <41F2E7BB.2050405@hotmail.com>
 <1106440494.20995.44.camel@tux.rsn.bth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch worked. Or at least it built.

Thanks for the quick response.

sean

Martin Josefsson wrote:


> Try this patch:
> 
> diff -X dontdiff.ny -urNp linux-2.6.11-rc2.orig/include/linux/netfilter_ipv4/ip_conntrack_tftp.h linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack_tftp.h
> --- linux-2.6.11-rc2.orig/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-01-22 15:23:45.000000000 +0100
> +++ linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-01-23 01:31:25.000000000 +0100
> @@ -13,7 +13,7 @@ struct tftphdr {
>  #define TFTP_OPCODE_ACK		4
>  #define TFTP_OPCODE_ERROR	5
>  
> -unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
> +extern unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
>  				 enum ip_conntrack_info ctinfo,
>  				 struct ip_conntrack_expect *exp);


