Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWH2IK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWH2IK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWH2IK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:10:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2995 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750911AbWH2IK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:10:57 -0400
Subject: Re: [RPC] OLPC tablet input driver.
From: Arjan van de Ven <arjan@infradead.org>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
In-Reply-To: <20060829073339.GA4181@aehallh.com>
References: <20060829073339.GA4181@aehallh.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 29 Aug 2006 10:10:19 +0200
Message-Id: <1156839019.2722.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#undef DEBUG
> +#ifdef DEBUG
> +#define dbg(format, arg...) printk(KERN_INFO "olpc.c(%d): " format "\n", __LINE__, ## arg)
> +#else
> +#define dbg(format, arg...) do {} while (0)
> +#endif

why not use pr_debug or even dev_debug() ?
Those already have this ifdef included

> +
> +static struct olpc_model_info olpc_model_data[] = {
> +	{ { 0x67, 0x00, 0x0a }, 0xeb, 0xff, OLPC_PTGS },	/* OLPC in PT+GS mode. */
> +};

const?



also.. there's no locking visible anywhere in the driver... is this
right?

Greetings,
   Arjan van de Ven

