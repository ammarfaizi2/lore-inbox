Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263106AbVGNTy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbVGNTy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVGNTvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:51:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12737 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261603AbVGNTuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:50:39 -0400
Date: Thu, 14 Jul 2005 20:50:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc2-mm2 5/7] v9fs: 9P protocol implementation (2.0.2)
Message-ID: <20050714195034.GA22576@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, ericvh@gmail.com,
	linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
	akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <200507141830.j6EIUpRZ023698@ms-smtp-03-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507141830.j6EIUpRZ023698@ms-smtp-03-eri0.texas.rr.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void buf_check_size(struct cbuf *buf, int len) 
> +{
> +	if (buf->p+len > buf->ep) { 
> +		if (buf->p < buf->ep) { 
> +			eprintk(KERN_ERR, "buffer overflow\n"); 
> +			buf->p = buf->ep + 1; 
> +		} 
> +	} 
> +}

"handling" a buffer overflow with a printk doesn't seem appopinquate.
In what cases can this happen and what problems may it cause?

