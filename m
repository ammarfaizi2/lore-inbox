Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTEBApt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbTEBAps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:45:48 -0400
Received: from [12.47.58.20] ([12.47.58.20]:63015 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262845AbTEBApr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:45:47 -0400
Date: Thu, 1 May 2003 17:54:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: dphillips@sistina.com
Cc: willy@w.ods.org, schlicht@uni-mannheim.de, hugang@soulinfo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030501175450.4afb1e48.akpm@digeo.com>
In-Reply-To: <200305020243.15248.dphillips@sistina.com>
References: <200304300446.24330.dphillips@sistina.com>
	<200305020127.26279.schlicht@uni-mannheim.de>
	<20030502001050.GA25789@alpha.home.local>
	<200305020243.15248.dphillips@sistina.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 00:58:03.0871 (UTC) FILETIME=[E2B386F0:01C31045]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <dphillips@sistina.com> wrote:
>
> On Friday 02 May 2003 02:10, Willy Tarreau wrote:
> > At first, I thought you had coded an FFS instead of an FLS. But I realized
> > it's valid, and is fast because one half of the numbers tested will not even
> > take one iteration.
> 
> Aha, and duh.  At 1 million iterations, my binary search clobbers the shift 
> version by a factor of four.  At 2**31 iterations, my version also wins, by 
> 20%.
> 

Would it be churlish to point out that the only significant user of fls()
is sctp_v6_addr_match_len()?

