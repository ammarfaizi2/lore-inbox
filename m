Return-Path: <linux-kernel-owner+w=401wt.eu-S932745AbXABJVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbXABJVc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 04:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbXABJVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 04:21:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42172 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbXABJVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 04:21:32 -0500
Date: Tue, 2 Jan 2007 09:21:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Amit Choudhary <amit2030@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Message-ID: <20070102092128.GA5686@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Amit Choudhary <amit2030@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061231161749.06e7f746.amit2030@gmail.com> <84144f020701011323w1350b9a9n2baa2245f716a221@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020701011323w1350b9a9n2baa2245f716a221@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 11:23:20PM +0200, Pekka Enberg wrote:
> NAK until you have actual callers for it. CONFIG_SLAB_DEBUG already
> catches use after free and double-free so I don't see the point of
> this.

And CONFIG_SLAB_DEBUG actually finds them for real using poisoning,
unlike setting the pointer to NULL which is too magic to catch most
bugs but rather papers over them.

