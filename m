Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756530AbWKSJrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530AbWKSJrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 04:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbWKSJrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 04:47:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756530AbWKSJrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 04:47:24 -0500
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061118000629.GW31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061117142145.GX31879@stusta.de>
	 <20061117143236.GA23210@devserv.devel.redhat.com>
	 <20061118000629.GW31879@stusta.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 19 Nov 2006 10:47:12 +0100
Message-Id: <1163929632.31358.481.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Oh, and if anything starts complaining "But this adds some warnings to 
> my kernel build!", he should either first fix the 200 kB (sic) of 
> warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.

we can solve this btw; we could have a

#define THIS_MODULE_IS_LEGACY_CRAP_AND_WONT_GET_FIXED

that would turn __deprecated into a nop for those few legacy modules
inside the kernel that nobody really is looking after.

(and yes the define should be really offensive so that nobody will put
it in a maintained module, and maybe it should even cause the kernel to
printk something when such a module gets loaded into the kernel)

If this sounds like a good idea I'll code it up...


