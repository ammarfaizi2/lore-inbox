Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWDXXu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWDXXu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWDXXu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:50:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932126AbWDXXu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:50:26 -0400
Date: Mon, 24 Apr 2006 16:52:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, aherrman@de.ibm.com
Subject: Re: [patch 5/13] s390: qdio memory allocations.
Message-Id: <20060424165252.1282e0f0.akpm@osdl.org>
In-Reply-To: <20060424150348.GF15613@skybase>
References: <20060424150348.GF15613@skybase>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> -	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	ssqd_area = mempool_alloc(qdio_mempool_scssc, GFP_ATOMIC);

I assume the loss of GFP_DMA was intentional?
