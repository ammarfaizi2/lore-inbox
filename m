Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWIYKPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWIYKPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWIYKPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:15:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40122 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750983AbWIYKPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:15:17 -0400
Subject: Re: [PATCH] libata: rework legacy handling to remove much of the
	cruft
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>,
       rmk@arm.linux.org.uk
In-Reply-To: <200609241805.k8OI5Xkn007593@hera.kernel.org>
References: <200609241805.k8OI5Xkn007593@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 11:14:50 +0100
Message-Id: <1159179290.320.11.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 18:05 +0000, Linux Kernel Mailing List wrote:
> 
> +#define ATA_PRIMARY_CMD                0x1F0
> +#define ATA_PRIMARY_CTL                0x3F6
> +#define ATA_PRIMARY_IRQ                14
> +
> +#define ATA_SECONDARY_CMD      0x170
> +#define ATA_SECONDARY_CTL      0x376
> +#define ATA_SECONDARY_IRQ      15

Please, don't do this. We've only just cleaned up the serial driver to
get rid of crap like this -- we _don't_ want to do it like this.

We should register the non-discoverable devices as platform devices (or
of_devices, or something), and not just hardcode stuff like this in
asm/foo.h headers.

-- 
dwmw2

