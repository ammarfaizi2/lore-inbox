Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVDEQsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVDEQsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVDEQsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:48:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261811AbVDEQsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:24 -0400
Subject: Re: 2.6.12-rc2-mm1
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050405074530.GF26208@infradead.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	 <20050405074530.GF26208@infradead.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 17:48:20 +0100
Message-Id: <1112719700.24487.415.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 08:45 +0100, Christoph Hellwig wrote:
> This introduces various AUDIT_ARCH numerical constants, which is a blatantly
> stupid idea.  We already have a way to uniquely identify architectures, and
> that's the ELF headers, no need for another parallel namespace.

We do use the EM_xxx number space but that isn't sufficient to
distinguish between 32-bit and 64-bit incarnations of certain machine
types (S390,SH,MIPS,...). I didn't much like adding it either, but
couldn't see a better option.

I pondered strings but we want to filter on this and don't want to have
to use strcmp. Got any better answers?

> (btw, could you please add to all patches who's responsible for them,
> bk-audit.patch doesn't tell)

If it were just to point to the BK tree, that might help.
 ( linux-audit.bkbits.net/audit-2.6-mm )

-- 
dwmw2

