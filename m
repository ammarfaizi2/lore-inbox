Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUBXJhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 04:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUBXJhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 04:37:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:42369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261573AbUBXJho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 04:37:44 -0500
Date: Tue, 24 Feb 2004 01:37:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-Id: <20040224013750.4c201590.akpm@osdl.org>
In-Reply-To: <20040224093056.GA31521@dingdong.cryptoapps.com>
References: <20040222175507.558a5b3d.akpm@osdl.org>
	<40396ACD.7090109@cyberone.com.au>
	<40396DA7.70200@cyberone.com.au>
	<4039B4E6.3050801@cyberone.com.au>
	<4039BE41.1000804@cyberone.com.au>
	<20040223005948.10a3b325.akpm@osdl.org>
	<20040223224723.GA27639@dingdong.cryptoapps.com>
	<403ACEFC.4070208@cyberone.com.au>
	<20040224091200.GA31360@dingdong.cryptoapps.com>
	<20040224012222.453e7db7.akpm@osdl.org>
	<20040224093056.GA31521@dingdong.cryptoapps.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> I just notice I'm getting debugging output (call traces) for page
>  allocation failures which I've not seem before.  I was getting these
>  (swapper: page allocation failure. order:2, mode:0x20) after beating
>  things to see how bad things will get for Nick.

Order *two*?  That's four physically contiguous pages.  We haven't got a
snowball's chance of satisfying an order-2 GFP_ATOMIC allocation for
networking.

What's the call backtrace on these failures?

