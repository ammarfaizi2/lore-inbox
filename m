Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWHPNLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWHPNLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWHPNLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:11:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47082 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751171AbWHPNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:11:03 -0400
Date: Wed, 16 Aug 2006 14:10:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: Re: [patch] s390: kernel page table allocation.
Message-ID: <20060816131042.GB13251@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
References: <20060816120622.GD24551@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816120622.GD24551@skybase>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		pg_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> +		pg_table = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);

Again, no need to cast the alloc_bootmem_pages return value.

