Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbVIYIUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbVIYIUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVIYIUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:20:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35529 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751243AbVIYIUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:20:35 -0400
Subject: Re: [PATCH] Remove DRM_ARRAY_SIZE
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Michael Veeck <michael.veeck@gmx.net>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509250054190.24532@skynet>
References: <20050924211139.GA18795@mipter.zuzino.mipt.ru>
	 <Pine.LNX.4.58.0509250054190.24532@skynet>
Content-Type: text/plain
Date: Sun, 25 Sep 2005 10:20:21 +0200
Message-Id: <1127636422.16288.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-25 at 00:56 +0100, Dave Airlie wrote:
> >
> > drivers/char/drm/drmP.h defines a macro DRM_ARRAY_SIZE(x) for
> > determining the size of an array. kernel.h already provides one.
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Nak.
> 
> We have DRM_ for cross platform reasons in DRM, I could in theory get rid
> of all of them in the kernel, but it would make the merging of code from
> DRM CVS even more of a nightmare,

ok so this brings the question: how does naming it DRM_ARRAY_SIZE make
it more portable than naming it ARRAY_SIZE?
If *BSD doesn't have ARRAY_SIZE, then surely naming it ARRAY_SIZE is
easy for them to provide (after all they need to provide it already just
called DRM_ARRAY_SIZE); if they have ARRAY_SIZE... then I assume it has
the exact same semantics....



