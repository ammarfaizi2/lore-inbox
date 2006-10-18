Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWJRPJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWJRPJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWJRPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:09:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161138AbWJRPJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:09:50 -0400
Date: Wed, 18 Oct 2006 16:09:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM killer meets userspace headers
Message-ID: <20061018150948.GA7371@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20061018145305.GA5345@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018145305.GA5345@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 06:53:05PM +0400, Alexey Dobriyan wrote:
> Despite mm.h is not being exported header, it does contain one thing
> which is part of userspace ABI -- value disabling OOM killer. So,
> a) export mm.h to userspace
> b) got OOM_DISABLE disable define out of __KERNEL__ prison.
> c) turn bound values suitable for /proc/$PID/oom_adj into defines and export
>    them too.
> d) put some headers into __KERNEL__ prison. It'd bizarre to include mm.h and
>    get capability stuff.

NACK, mm.h is far too big for that.  Just create a tiny oom.h for those
values.

