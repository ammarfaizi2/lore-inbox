Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUIIDSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUIIDSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUIIDSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:18:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269266AbUIIDSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:18:07 -0400
Message-ID: <413FCB61.7060604@pobox.com>
Date: Wed, 08 Sep 2004 23:17:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch][3/9] ide: add ide_sg_init() helper
References: <200409082126.49832.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409082126.49832.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> +static inline void ide_sg_init(struct scatterlist *sg, u8 *buf, unsigned int buflen)
> +{
> +	memset(sg, 0, sizeof(*sg));
> +
> +	sg->page = virt_to_page(buf);
> +	sg->offset = offset_in_page(buf);
> +	sg->length = buflen;
> +}
> +


Surely this should be more generic?

	Jeff


