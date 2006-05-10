Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWEJUFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWEJUFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWEJUFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:05:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751511AbWEJUFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:05:21 -0400
Date: Wed, 10 May 2006 21:05:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Hugetlb demotion for x86
Message-ID: <20060510200516.GA30346@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.kernel.org,
	linux-kernel@vger.kernel.org
References: <1147287400.24029.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147287400.24029.81.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 01:56:40PM -0500, Adam Litke wrote:
> The following patch enables demotion of MAP_PRIVATE hugetlb memory to
> normal anonymous memory on the i386 architecture.

This is an awfully bad idea.  Applications should do smart fallback
instead.  For the same reason we for example fail O_DIRECT requests
we can fullfill instead of doing the half buffered I/O braindamage
solaris does.

