Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTFKJ7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTFKJ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:59:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:17167 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264324AbTFKJ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:59:31 -0400
Date: Wed, 11 Jun 2003 14:12:44 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH][ALPHA] PCI domains warning
Message-ID: <20030611141244.A24560@jurassic.park.msu.ru>
References: <wrpd6hlauw9.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrpd6hlauw9.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Wed, Jun 11, 2003 at 10:19:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 10:19:34AM +0200, Marc Zyngier wrote:
> +#ifdef CONFIG_PCI_DOMAINS
>  #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
> +#endif

Alternatively, we can set CONFIG_PCI_DOMAINS=y unconditionally to
avoid ifdefs - jensen has dummy PCI infrastructure anyway.

Ivan.

--- 2.5/arch/alpha/Kconfig	Wed Jun 11 13:13:56 2003
+++ linux/arch/alpha/Kconfig	Wed Jun 11 13:54:37 2003
@@ -297,7 +297,7 @@ config PCI
 
 config PCI_DOMAINS
 	bool
-	default PCI
+	default y
 
 config ALPHA_CORE_AGP
 	bool
