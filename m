Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWHWIWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWHWIWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWHWIWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:22:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50832 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964784AbWHWIWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:22:51 -0400
Subject: Re: [PATCH 11/18] 2.6.17.9 perfmon2 patch for review: file related
	operations support
From: Arjan van de Ven <arjan@infradead.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
In-Reply-To: <200608230806.k7N862CD000468@frankl.hpl.hp.com>
References: <200608230806.k7N862CD000468@frankl.hpl.hp.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 23 Aug 2006 10:22:28 +0200
Message-Id: <1156321348.2829.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 01:06 -0700, Stephane Eranian wrote:
> +struct file_operations pfm_file_ops = {
> +	.llseek = no_llseek,
> +	.read = pfm_read,
> +	.write = pfm_write,
> +	.poll = pfm_poll,
> +	.ioctl = pfm_ioctl,
> +	.open = pfm_no_open, /* special open to disallow open via /proc */
> +	.fasync = pfm_fasync,
> +	.release = pfm_close,
> +	.flush= pfm_flush,
> +	.mmap = pfm_mmap
> +};

these should be const


