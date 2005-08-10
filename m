Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVHJXYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVHJXYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVHJXYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:24:07 -0400
Received: from pat.uio.no ([129.240.130.16]:3969 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932599AbVHJXYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:24:06 -0400
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <200508110857.06539.phillips@arcor.de>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508110823.53593.phillips@arcor.de>
	 <1123713258.10292.109.camel@lade.trondhjem.org>
	 <200508110857.06539.phillips@arcor.de>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 19:23:56 -0400
Message-Id: <1123716236.8082.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.926, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 08:57 (+1000) skreiv Daniel Phillips:
> > What "NFS-related colliding use of page flags bit 8"?
> 
> As explained to me:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112368417412580&w=2

Oh. You are talking about CacheFS? That hasn't been declared "ready to
merge" yet.

That said, is it really safe to use any flags other than
PG_lock/PG_writeback there, David? I can't see that you want to allow
other tasks to modify or free the page while you are writing it to the
local cache.

Cheers,
  Trond

