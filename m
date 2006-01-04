Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWADKfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWADKfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWADKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:35:11 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41688 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751236AbWADKfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:35:09 -0500
Date: Wed, 4 Jan 2006 05:35:03 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __getname vs kmalloc
Message-ID: <20060104103503.GA8708@filer.fsl.cs.sunysb.edu>
References: <20060104063251.GA4263@filer.fsl.cs.sunysb.edu> <1136369969.28640.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136369969.28640.24.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 11:19:29AM +0100, Trond Myklebust wrote:
> On Wed, 2006-01-04 at 01:32 -0500, Josef Sipek wrote:
> > Which is the prefered method of allocating memory __getname or kmalloc?
> 
> Depends entirely on the purpose. __getname uses the "names_cache" slab
> and allocates PATH_MAX sized chunks. It is mainly supposed to be used
> for temporary storage of an entire path.
>
> Most callers use getname(), which also does the string length sanity
> checks and then copies the path from userland memory.

Ah, so since I am working with path components that'll get most of the
time passed to lookup_one_len & friends, kmalloc is the better way to
get memory, correct?

Thanks,
Jeff Sipek
