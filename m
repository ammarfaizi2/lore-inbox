Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUIJHwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUIJHwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUIJHwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:52:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:36489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266341AbUIJHv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:51:28 -0400
Date: Fri, 10 Sep 2004 00:49:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040910004935.15ee7b10.akpm@osdl.org>
In-Reply-To: <41415B15.1050402@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
	<20040909010610.28ca50e1.akpm@osdl.org>
	<4140EE3E.5040602@bigpond.net.au>
	<20040909171450.6546ee7a.akpm@osdl.org>
	<4141092B.2090608@bigpond.net.au>
	<20040909200650.787001fc.akpm@osdl.org>
	<41413F64.40504@bigpond.net.au>
	<20040909231858.770ab381.akpm@osdl.org>
	<414149A0.1050006@bigpond.net.au>
	<20040909235217.5a170840.akpm@osdl.org>
	<41415B15.1050402@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
>  > It would be useful if you could experiment with CONFIG_DEBUG_SLAB and
>  > CONFIG_DEBUG_PAGEALLOC.
> 
>  With both of those enabled and all four patches applied the oops and the 
>  scheduling while atomic have stopped BUT I'm now getting 4  identical 
>  oops in kfree which seem to be associated with a segment fault in mount 
>  while my start up script is mounting some iso files with loopback.

gack.  One bug at a time, OK?

Please drop those four patches - that idea didn't work out.

So we know that enabling CONFIG_DEBUG_SLAB and/or CONFIG_DEBUG_PAGEALLOC
makes the in_group_p() crash go away, yes?

Running out of ideas here.  If you could, please try enabling those debug
options separately, see if that tells us something.

