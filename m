Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVCONoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVCONoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVCONle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:41:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48808 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261223AbVCONkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:40:53 -0500
Subject: Re: 2.6.11-mm3 breaks compile of drivers/char/esp.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050314203357.75aacaaf.akpm@osdl.org>
References: <200503121839.36970.bero@arklinux.org>
	 <20050314203357.75aacaaf.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110893915.15943.180.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Mar 2005 13:38:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-15 at 04:33, Andrew Morton wrote:
> --- 25/include/linux/hayesesp.h~esp-build-fix	2005-03-14 20:31:18.000000000 -0800
> +++ 25-akpm/include/linux/hayesesp.h	2005-03-14 20:31:30.000000000 -0800
> @@ -77,6 +77,7 @@ struct hayes_esp_config {
>  
>  struct esp_struct {
>  	int			magic;
> +	spinlock_t		lock;
>  	int			port;
>  	int			irq;
>  	int			flags; 		/* defined in tty.h */

> I didn't pick this up because ESPSERIAL is still BROKEN_ON_SMP.  Alan,
> should we remove that now?

I think so yes. Needs a bit more testing to be totally sure

