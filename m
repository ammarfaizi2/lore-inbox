Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269571AbUICBv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269571AbUICBv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUICBtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:49:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22498 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S269555AbUICBpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:45:39 -0400
Date: Thu, 2 Sep 2004 18:45:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC 2.6.9-rc1 2/2] zlib_inflate: Add __BOOTER__ around zlib_inflate_trees_fixed(...)
Message-ID: <20040903014520.GE26144@smtp.west.cox.net>
References: <20040901231659.GA20624@smtp.west.cox.net> <20040902173626.GB26144@smtp.west.cox.net> <20040902174707.GC26144@smtp.west.cox.net> <16695.50554.389435.137893@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16695.50554.389435.137893@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 11:14:34AM +1000, Paul Mackerras wrote:

> Tom Rini writes:
> 
> > This is the second part of what I found.  zlib_inflate_trees_fixed(...)
> > isn't called in decompressing a kernel.  Dropping this, and the call to
> 
> I think it is just luck that gzip hasn't used the fixed table in
> compressing the kernel.  I don't think we have any guarantee that gzip
> won't use the fixed table.

That is a good point.  Looking at arch/ppc/boot/lib/zlib.c it generates
the table, instead of having a static one.  So perhaps we should move to
that instead for lib/zlib_inflate ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
