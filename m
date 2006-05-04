Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWEDC0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWEDC0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 22:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWEDC0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 22:26:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750858AbWEDC0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 22:26:32 -0400
Date: Wed, 3 May 2006 19:26:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, pfg@sgi.com, jeremy@sgi.com, jes@sgi.com
Subject: Re: [PATCH] SGI IOC4: Detect IO card variant
Message-Id: <20060503192626.1bc3af56.akpm@osdl.org>
In-Reply-To: <20060503171758.H59683@chenjesu.americas.sgi.com>
References: <20060503171758.H59683@chenjesu.americas.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 17:21:23 -0500 (CDT)
Brent Casavant <bcasavan@sgi.com> wrote:

> +#ifndef PCI_DEVICE_ID_QLOGIC_ISP12160
> +#define PCI_DEVICE_ID_QLOGIC_ISP12160 0x1216
> +#endif
> +#ifndef PCI_VENDOR_ID_VITESSE
> +#define PCI_VENDOR_ID_VITESSE 0x1725
> +#endif
> +#ifndef PCI_DEVICE_ID_VITESSE_7174
> +#define PCI_DEVICE_ID_VITESSE_7174 0x7174
> +#endif

We shouldn't need the ifdefs here.  Let's just get the right defines in the
right place and use them.

I'm unable to work out whether this problem which this patch fixes warrants
a 2.6.17 merge.

