Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUIJFlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUIJFlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUIJFlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:41:35 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:39407 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268238AbUIJFel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:34:41 -0400
Date: Thu, 9 Sep 2004 22:34:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: akpm@osdl.org, hugh@veritas.com, ak@muc.de, wli@holomorphy.com,
       takata.hirokazu@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_inc_return() for i386[1/5] (Re: atomic_inc_return)
Message-ID: <20040910053424.GA3668@taniwha.stupidest.org>
References: <Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain> <200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 12:26:54PM +0900, Kaigai Kohei wrote:

> +static __inline__ int atomic_add_return(int i, atomic_t *v)
> +{
> +	int __i;
> +#ifdef CONFIG_M386
> +	if(unlikely(boot_cpu_data.x86==3))
> +		goto no_xadd;
> +#endif

i didn't check what code is generated, but isn't that expensive?  i
guess most people building i386 kernels want maximum compatability so
it probably doesn't matter...
