Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUIQHYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUIQHYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268529AbUIQHYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:24:07 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:55565 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268527AbUIQHX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:23:58 -0400
Date: Fri, 17 Sep 2004 08:23:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 1/2
Message-ID: <20040917082344.B10537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1095332323.3855.159.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1095332323.3855.159.camel@laptop.cunninghams>; from ncunningham@linuxmail.org on Thu, Sep 16, 2004 at 08:58:44PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct partial_device_tree default_device_tree =
> +{ 
> +	.dpm_active	= LIST_HEAD_INIT(default_device_tree.dpm_active),
> +	.dpm_off	= LIST_HEAD_INIT(default_device_tree.dpm_off),
> +	.dpm_off_irq	= LIST_HEAD_INIT(default_device_tree.dpm_off_irq),
> +};
> +EXPORT_SYMBOL(default_device_tree);


_never_ exports lists, only accessory funktions.  But honestly please get
some builtin code merged first, then think about making it modular.

We don't want to add random exports just to see them never used later on.
