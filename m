Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265634AbUAPSO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUAPSO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:14:58 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:10447 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265634AbUAPSOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:14:47 -0500
Date: Fri, 16 Jan 2004 10:14:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Re: Linux 2.4.25-pre6
Message-ID: <20040116181429.GK1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58L.0401161207000.28357@logos.cnet> <000b01c3dc46$44cc3180$0e25fe96@southpark.ae.poznan.pl> <001701c3dc48$d05763d0$0e25fe96@southpark.ae.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c3dc48$d05763d0$0e25fe96@southpark.ae.poznan.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 04:52:49PM +0100, Maciej Soltysiak wrote:
> >   o [IPV4]: Print correct source addr in invalid ICMP msgs, from Dennis
> Jorgensen
> Oh, and the same patch should be applied to 2.6 too.
> 
> Regards,
> Maciej
> 
> dns:/usr/src/linux/net/ipv4# diff -u icmp.c~ icmp.c
> --- icmp.c~     2003-12-18 03:59:40.000000000 +0100
> +++ icmp.c      2004-01-16 16:47:28.000000000 +0100
> @@ -670,7 +670,7 @@
>                         printk(KERN_WARNING "%u.%u.%u.%u sent an invalid
> ICMP "
>                                             "type %u, code %u "
>                                             "error to a broadcast:
> %u.%u.%u.%u on %s\n",
> -                              NIPQUAD(skb->nh.iph->saddr),
> +                              NIPQUAD(iph->saddr),

Looks like it wrapped...
