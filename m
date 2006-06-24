Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWFXVnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWFXVnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWFXVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:43:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751107AbWFXVno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:43:44 -0400
Date: Sat, 24 Jun 2006 14:43:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-mm2
Message-Id: <20060624144321.e41cf408.akpm@osdl.org>
In-Reply-To: <200606242141.41055.dominik.karall@gmx.net>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<200606242141.41055.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 21:41:41 +0200
Dominik Karall <dominik.karall@gmx.net> wrote:

> On Saturday, 24. June 2006 15:19, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> >7/2.6.17-mm2/
> 
> hi!
> 
> I get this warning on make modules_install:
> 
> WARNING: /lib/modules/2.6.17-mm2/kernel/net/ieee80211/ieee80211.ko 
> needs unknown symbol wireless_spy_update
> 

Someone removed the `#ifdef CONFIG_WIRELESS_EXT' from around the callsite
in net/ieee80211/ieee80211_rx.c and didn't update Kconfig appropriately.

Presumably, setting CONFIG_WIRELESS_EXT will get you going again.
