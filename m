Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWBWHrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWBWHrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 02:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWBWHq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 02:46:59 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:13847 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750729AbWBWHq6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 02:46:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eULiP9Heu4i3Z66zgFNxlDFmAk6cW9DJQyXyoYmzBiV/Lkb5qT5qf5oS86HVe0lmj6UGZNyLROd5A9fXoQo3IBmR9cJOpXYDV03fXAomLR03vzfG6Lyc/N5aK0Ybu0/tRwWcH+DJbSzxTLvX6NwZfnFDt2pI+d4Us5a+xMF0XFE=
Message-ID: <84144f020602222346m70a41867vd2387fbfc2cfe547@mail.gmail.com>
Date: Thu, 23 Feb 2006 09:46:44 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@engr.sgi.com>
Subject: Re: slab: Remove SLAB_NO_REAP option
Cc: akpm@osdl.org, alokk@calsoftinc.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602221428510.30219@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602221428510.30219@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/23/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> SLAB_NO_REAP is documented as an option that will cause this slab
> not to be reaped under memory pressure. However, that is not what
> happens. The only thing that SLAB_NO_REAP controls at the moment
> is the reclaim of the unused slab elements that were allocated in
> batch in cache_reap(). Cache_reap() is run every few seconds
> independently of memory pressure.
>
> Could we remove the whole thing? Its only used by three slabs
> anyways and I cannot find a reason for having this option.

Looks good, and I have been meaning to do this myself as well.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

P.S. Please use penberg@cs.helsinki.fi, not the gmail one. Thanks.

                               Pekka
