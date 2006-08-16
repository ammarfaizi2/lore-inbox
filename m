Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWHPNKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWHPNKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWHPNKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:10:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45546 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751166AbWHPNKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:10:09 -0400
Date: Wed, 16 Aug 2006 14:09:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: Re: [patch] s390: dasd calls kzalloc while holding a spinlock.
Message-ID: <20060816130945.GA13251@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
References: <20060816120449.GA24551@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816120449.GA24551@skybase>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	srv = (struct dasd_servermap *)
> +		kzalloc(sizeof(struct dasd_servermap), GFP_KERNEL);

No need to cast the kzalloc return value to a pointer type.
