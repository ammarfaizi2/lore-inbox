Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHGStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHGStk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHGStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:49:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:15827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263626AbUHGSti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:49:38 -0400
Date: Sat, 7 Aug 2004 11:49:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Shoemaker <c.shoemaker@cox.net>
cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040807134414.GA16953@cox.net>
Message-ID: <Pine.LNX.4.58.0408071147460.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org>
 <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
 <20040806230924.GA15493@cox.net> <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org>
 <20040807134414.GA16953@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Aug 2004, Chris Shoemaker wrote:
> 
> Well then, maybe you'd like more?  I attached two more from the same
> period.  Please remember that these are 5 months old, and could
> represent bugs already fixed.  I think this was stock 2.6.4.

These look like total memory corruption, they don't look anything like the 
prune_dcache things. 

> Perhaps due to CONFIG_REGPARM?  I haven't used it for quite a while, but
> back in March I was a bit bolder about config options marked
> experimental.

Entirely possible. gcc has historically had bugs in regparm (extra 
register pressure causing incorrect register re-use). It's supposed to be 
fixed in gcc-3+

		Linus
