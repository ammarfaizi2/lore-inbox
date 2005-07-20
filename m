Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVGTLEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVGTLEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVGTLEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:04:23 -0400
Received: from [81.2.110.250] ([81.2.110.250]:35200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261151AbVGTLEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:04:21 -0400
Subject: Re: [2.6 patch] VIA_VELOCITY must depend on INET
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050719135523.GF5031@stusta.de>
References: <20050719135523.GF5031@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Jul 2005 12:26:26 +0100
Message-Id: <1121858786.11024.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-07-19 at 15:55 +0200, Adrian Bunk wrote:
> VIA_VELOCITY=y and INET=n results in the following compile error:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `velocity_register_notifier':
> via-velocity.c:(.text+0x3462c6): undefined reference to `register_inetaddr_notifier'
> drivers/built-in.o: In function `velocity_unregister_notifier':
> via-velocity.c:(.text+0x3462d6): undefined reference to `unregister_inetaddr_notifier'
> make: *** [.tmp_vmlinux1] Error 1

Alternatively you could drop those functions when CONFIG_INET is n as
they are only used for wake on arp

