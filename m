Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUD3GSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUD3GSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUD3GSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:18:17 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:56850 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265065AbUD3GR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:17:57 -0400
Date: Fri, 30 Apr 2004 07:17:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>, Paul Jackson <pj@sgi.com>,
       chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040430071750.A8515@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.SGI.4.53.0404291447220.732952@subway.americas.sgi.com> <Pine.LNX.4.44.0404291719400.9152-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0404291719400.9152-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Thu, Apr 29, 2004 at 05:20:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect there's a rather good chance of merging a common
> PAGG/CKRM infrastructure, since they pretty much do the same
> thing at the core and they both have different functionality
> implemented on top of the core process grouping.

Still doesn't make a lot of sense.  CKRM is a huge cludgy beast poking
everywhere while PAGG is a really small layer to allow kernel modules
keeping per-process state.  If CKRM gets merged at all (and the current
looks far to horrible and the gains are rather unclear) it should layer
ontop of something like PAGG for the functionality covered by it.

