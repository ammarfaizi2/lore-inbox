Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUEQL7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUEQL7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbUEQL7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:59:39 -0400
Received: from taco.zianet.com ([216.234.192.159]:14609 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S264982AbUEQL6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:58:35 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Mon, 17 May 2004 05:58:03 -0600
User-Agent: KMail/1.6.1
Cc: torvalds@osdl.org, lm@bitmover.com, wli@holomorphy.com, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <20040517002506.34022cb8.akpm@osdl.org> <20040517004626.4377a496.akpm@osdl.org>
In-Reply-To: <20040517004626.4377a496.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405170558.04065.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 01:46 am, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> >  If an application does mmap(MAP_SHARED) of, say, a 2048 byte file and then
> >  extends it:
> > 
> >  	p = mmap(..., fd, ...);
> >  	ftructate(fd, 4096);
> >  	p[3000] = 1;
> > 
> >  A racing block_write_full_page() could fail to notice the extended i_size
> >  and would decide to zap those 2048 bytes anyway.
> 
> This should plug it.

I'll test this tonight when I get back to this home machine.

Thanks, and thanks to Bitmover for providing the resources to help chase this bug.

Steven
