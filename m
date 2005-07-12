Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVGLWLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVGLWLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGLWJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:09:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262399AbVGLWHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:07:11 -0400
Date: Tue, 12 Jul 2005 23:07:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: rusty@rustcorp.com.au, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime fix for intermodule.c
Message-ID: <20050712220705.GA12906@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	rusty@rustcorp.com.au, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20050712213920.GA9714@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712213920.GA9714@physik.fu-berlin.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 11:39:20PM +0200, Adrian Glaubitz wrote:
> This little patch adds the missing function declaration
> of the deprecatated function call inter_module_get
> to the header file include/linux/module.h and the
> necessary EXPORT_SYMBOL to kernel/intermodule.c. Without
> the declaration and the EXPORT_SYMBOL any module that requires
> the inter_module_get call will fail upon loading
> since the symbol inter_module_get cannot be resolved,
> applying this patch will make those modules work again.

There's a reason you shouldn't use it, and because of that it's
not exported.

