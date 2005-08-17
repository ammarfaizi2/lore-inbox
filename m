Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVHQR4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVHQR4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVHQR4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:56:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41941 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751188AbVHQR4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:56:07 -0400
Date: Wed, 17 Aug 2005 18:56:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cleanup line-wrapping in pgtable.h
Message-ID: <20050817175601.GA19570@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adam Litke <agl@us.ibm.com>, linux-kernel@vger.kernel.org
References: <1124300739.3139.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124300739.3139.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline int pte_user(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_USER; }

Once you start reformatting things please make sure the result version
matches the documented codingstyle.  That would be:

static inline int pte_user(pte_t pte)
{
	return (pte).pte_low & _PAGE_USER;
}

Quite a bit more verbose, but also a lot better readable.

