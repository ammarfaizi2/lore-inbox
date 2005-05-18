Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVEROpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVEROpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVEROcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:32:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262193AbVERO2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:28:49 -0400
Date: Wed, 18 May 2005 15:28:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 4/5] loop: execute in place (V2)
Message-ID: <20050518142849.GC23162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, cotte@freenet.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	schwidefsky@de.ibm.com, akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424432.2202.19.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116424432.2202.19.camel@cotte.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 03:53:52PM +0200, Carsten Otte wrote:
> [RFC/PATCH 4/5] loop: execute in place (V2)
> The old loop driver in 2.6.11. used the readpage/writepage aops to
> transfer data. Now loop can also use read/write and direct_IO on the
> file if readpage/writepage are not available. Unlike the old 2.6.11.
> version, today's loop driver does work with files that do not have
> readpage/writepage. Threrefore, this patch is optional.
> This patch adds one more transport method to loop that uses the new
> address space operation get_xip_page if available.
> 
> This patch is unchanged from previous version.

This should be ifdef'ed to avoid bloat for non-XIP builds.  Or just be dropped
completely.  How much difference does it make over read/write and where does
loop performance matter?

