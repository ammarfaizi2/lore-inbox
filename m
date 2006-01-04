Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWADUf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWADUf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWADUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:35:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58876 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S965252AbWADUf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:35:27 -0500
Date: Wed, 4 Jan 2006 12:34:49 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Serge Noiraud <serge.noiraud@bull.net>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: RT : 2.6.15-rt1 and net/ipv6/mcast.c
In-Reply-To: <200601041832.39089.Serge.Noiraud@bull.net>
Message-ID: <Pine.LNX.4.64.0601041234130.22025@dhcp153.mvista.com>
References: <200601041832.39089.Serge.Noiraud@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought I submitted an identical patch, but maybe I forgot to CC LKML .

On Wed, 4 Jan 2006, Serge Noiraud wrote:

> Hi,
>
> 	On my i386 machine I can't compile. I have an error in net/ipv6/mcast.c
> I correct the error doing the correction below. No more compilation problem.
> Not yet tested. perhaps someone already submit it, but I received no mail today from vger.kernel.org
>
> Index: linux/net/ipv6/mcast.c
> ===================================================================
> --- linux.orig/net/ipv6/mcast.c
> +++ linux/net/ipv6/mcast.c
> @@ -224,7 +224,7 @@
>
>        mc_lst->ifindex = dev->ifindex;
>        mc_lst->sfmode = MCAST_EXCLUDE;
> -       mc_lst->sflock = RW_LOCK_UNLOCKED;
> +       mc_lst->sflock = RW_LOCK_UNLOCKED(mc_lst->sflock);
>        mc_lst->sflist = NULL;
>
>        /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
