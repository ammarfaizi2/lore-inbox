Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVGMITX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVGMITX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVGMITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 04:19:23 -0400
Received: from zs04.physik.fu-berlin.de ([160.45.35.155]:35302 "EHLO
	zs04.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id S262559AbVGMITU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 04:19:20 -0400
Date: Wed, 13 Jul 2005 10:19:17 +0200
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime fix for intermodule.c
Message-ID: <20050713081916.GA32417@physik.fu-berlin.de>
References: <20050712213920.GA9714@physik.fu-berlin.de> <20050712220705.GA12906@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712220705.GA12906@infradead.org>
User-Agent: Mutt/1.5.9i
From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Scanned: No viruses found.
X-Spam-Report: No (score -5.9)
        -3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-Scan-Signature: 2b1399c8af50b046452a5f406d32ed9f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This little patch adds the missing function declaration
> > of the deprecatated function call inter_module_get
> > to the header file include/linux/module.h and the
> > necessary EXPORT_SYMBOL to kernel/intermodule.c. Without
> > the declaration and the EXPORT_SYMBOL any module that requires
> > the inter_module_get call will fail upon loading
> > since the symbol inter_module_get cannot be resolved,
> > applying this patch will make those modules work again.
> 
> There's a reason you shouldn't use it, and because of that it's
> not exported.

I am sorry ! Since I didn't see any reason why not, I added
the export to code again to make my modem work with
the latest kernel versions. Well, I will need to try to
fix the driver then. I think I can use symbol_get instead,
can't I ?

Regards,

Adrian Glaubitz
