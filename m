Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265289AbUKAX7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUKAX7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S289538AbUKAX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:59:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37813 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S291050AbUKAX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:57:10 -0500
Subject: Re: [PATCH 6/14] FRV: IDE fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uclinux-dev@uclinux.org
In-Reply-To: <200411011930.iA1JULRt023195@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	 <200411011930.iA1JULRt023195@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099349584.16385.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 22:53:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-01 at 19:30, dhowells@redhat.com wrote:
>  		memset(&hwif->hw, 0, sizeof(hwif->hw));
> +#ifndef IDE_ARCH_OBSOLETE_INIT
> +		ide_std_init_ports(&hwif->hw, base, (ctl | 2));
> +		hwif->hw.io_ports[IDE_IRQ_OFFSET] = 0;
> +#else
>  		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
> +#endif

Do you really need this, and if so please why ?

