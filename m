Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267218AbUGVUVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267218AbUGVUVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUGVUVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:21:05 -0400
Received: from cfcafwp.sgi.com ([192.48.179.6]:35600 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267198AbUGVUVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:21:01 -0400
Date: Thu, 22 Jul 2004 15:20:45 -0500
From: Robin Holt <holt@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Robin Holt <holt@sgi.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Pat Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code re-org
Message-ID: <20040722202045.GA1177@lnx-holt.americas.sgi.com>
References: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com> <200407221357.53404.jbarnes@engr.sgi.com> <20040722192003.GA617@lnx-holt.americas.sgi.com> <20040722194050.GA797@lnx-holt.americas.sgi.com> <20040722194231.GA16991@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722194231.GA16991@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 08:42:31PM +0100, Christoph Hellwig wrote:
> > PS:  I found a few small problems with the bte code and will soon have
> > another patch that fixes that up.  Specifically, there were changes
> > made to bte_error.c and pda.h that are undone by your patch.
> 
> apropos bte, could you please merge bte_error.c into bte.c - there's no
> external callers of functions in bte_error.c except in bte.c

bte.c doesn't call bte_error.  That used to get called from shub_iio_error()
or something like that.  Would it be more appropriate to merge bte_error.c
into the callers file?  I would lean towards putting it into bte.c, but
your previous add implied it should go into the callers file.

Thanks,
Robin
