Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTEZOR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTEZOR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:17:57 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35090 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264386AbTEZOR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:17:56 -0400
Date: Mon, 26 May 2003 15:31:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.69-bk19 drm_memory.h compilation error
Message-ID: <20030526153107.A23896@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	lkml <linux-kernel@vger.kernel.org>, Linus <torvalds@transmeta.com>
References: <1053956681.1852.7.camel@nalesnik.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053956681.1852.7.camel@nalesnik.localhost>; from gj@pointblue.com.pl on Mon, May 26, 2003 at 02:44:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 02:44:44PM +0100, Grzegorz Jaskiewicz wrote:
>  #include <linux/config.h>
>  #include "drmP.h"
> 
> +/*
> + * we need PKMAP_BASE definition
> +*/
> +
> +#ifdef CONFIG_HIGHMEM
> +#include <asm/highmem.h>
> +#endif

Just include linux/highmem.h (never the asm version!) uncodintionally amd remove
the noisy comment.

