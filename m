Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFBUXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFBUXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFBUWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:22:03 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:1231
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261346AbVFBUUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:20:47 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Adrian Bunk'" <bunk@stusta.de>, "'Andrew Morton'" <akpm@osdl.org>,
       <jkmaline@cc.hut.fi>, <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <hostap@shmoo.com>, <netdev@oss.sgi.com>
Subject: RE: [-mm patch] fix recursive IPW2200 dependencies
Date: Thu, 2 Jun 2005 14:19:10 -0600
Message-ID: <003a01c567b0$56bed860$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050602200701.GG4992@stusta.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jun 01, 2005 at 02:28:24AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.12-rc5-mm1:
> >...
> > +git-netdev-we18-ieee80211-wifi.patch
> >
> >  Various things added and merged in netdev land.
> >...
>
> This results in recursive dependencies:
> - IPW2200 depends on NET_RADIO
> - IPW2200 selects IEEE80211
> - IEEE80211 selects NET_RADIO
>
>
> This patch fixes the IPW2200 dependencies in a way that they
> are similar
> to the IPW2100 dependencies.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
> linux-2.6.12-rc5-mm2-full/drivers/net/wireless/Kconfig.old
> 2005-06-02 22:04:02.000000000 +0200
> +++ linux-2.6.12-rc5-mm2-full/drivers/net/wireless/Kconfig
> 2005-06-02 22:04:40.000000000 +0200
> @@ -192,9 +192,8 @@
>
>  config IPW2200
>  	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network
> Connection"
> -	depends on NET_RADIO && PCI
> +	depends on IEEE80211 && PCI
>  	select FW_LOADER
> -	select IEEE80211
>  	---help---
>            A driver for the Intel PRO/Wireless 2200BG and
> 2915ABG Network
>  	  Connection adapters.

I think the normal usage of the name is Intel PRO/Wireless 2200BG/2915ABG
Network Connection. I'm just saying this in case that you care about Intel
Trademarking or about a more unified usage of the name of the Adapter.

maybe this is something silly.

.Alejandro

