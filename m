Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDJMJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDJMJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVDJMJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:09:54 -0400
Received: from postel.suug.ch ([195.134.158.23]:14002 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261483AbVDJMJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:09:46 -0400
Date: Sun, 10 Apr 2005 14:10:05 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com,
       jamal <hadi@cyberus.ca>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050410121005.GF26731@postel.suug.ch>
References: <1112942924.28858.234.camel@uganda> <E1DKZ7e-00070D-00@gondolin.me.apana.org.au> <20050410143205.18bff80d@zanzibar.2ka.mipt.ru> <1113131325.6994.66.camel@localhost.localdomain> <20050410153757.104fe611@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410153757.104fe611@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Evgeniy Polyakov <20050410153757.104fe611@zanzibar.2ka.mipt.ru> 2005-04-10 15:37
> --- ./net/netlink/af_netlink.c.orig     2005-04-10 15:46:48.000000000 +0400
> +++ ./net/netlink/af_netlink.c  2005-04-10 15:47:04.000000000 +0400
> @@ -747,7 +747,7 @@
>         if (p->exclude_sk == sk)
>                 goto out;
>  
> -       if (nlk->pid == p->pid || !(nlk->groups & p->group))
> +       if (nlk->pid == p->pid || (nlk->groups != p->group))
>                 goto out;
>  
>         if (p->failure) {

Not valid, would break RTMGRP_*.
