Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUEYUnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUEYUnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUEYUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:43:17 -0400
Received: from canuck.infradead.org ([205.233.217.7]:64004 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S265203AbUEYUnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:43:16 -0400
Date: Tue, 25 May 2004 16:43:05 -0400
From: hch@infradead.org
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Peter J. Braam" <braam@clusterfs.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040525204305.GA17448@infradead.org>
Mail-Followup-To: hch@infradead.org,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	"Peter J. Braam" <braam@clusterfs.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <20040524120315.GC26863@infradead.org> <200405241533.i4OFXnI01224@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405241533.i4OFXnI01224@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 11:33:49AM -0400, Horst von Brand wrote:
> Won't you also need a non-__ version, perhaps like so:
> 
>    void d_rehash(struct dentry *entry)
>    {
>        spin_lock(&dcache_lock);
>        __d_rehash(entry);
>        spin_unlock(&dcache_lock);
>    }
>    EXPORT_SYMBOL(d_rehash);
> 
> ?

Yes, and that is in fact included in their patch, I just didn't
quote it because it didn't seem relevant for the review.

One more reason why review requests for an url to a tarball of patches
are evil..

