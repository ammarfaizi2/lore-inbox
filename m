Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbUKUVRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUKUVRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUKUVRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:17:24 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261811AbUKUVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:15:02 -0500
Date: Sun, 21 Nov 2004 21:14:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ptb@inv.it.uc3m.es, ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: can kfree sleep?
Message-ID: <20041121211451.GA12826@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, ptb@inv.it.uc3m.es, ptb@it.uc3m.es,
	linux-kernel@vger.kernel.org
References: <200411211223.iALCNCTL005995@betty.it.uc3m.es> <20041121131038.6c55b91c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121131038.6c55b91c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 01:10:38PM -0800, Andrew Morton wrote:
> Nope.  All memory freeing codepaths are atomic and may be called from any
> context except NMI handlers.

Not true for vfree()

