Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUKTQck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUKTQck (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUKTQbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:31:18 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:49416 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263101AbUKTQbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:31:11 -0500
Date: Sat, 20 Nov 2004 16:31:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041120163110.GB19099@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
	Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
	Keir.Fraser@cl.cam.ac.uk
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -42,7 +42,12 @@ extern void tapechar_init(void);
>   */
>  static inline int uncached_access(struct file *file, unsigned long addr)

Any chance you could just move uncached_access() to some asm/ header for
all arches instead of making the ifdef mess even worse?

