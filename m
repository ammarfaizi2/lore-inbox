Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265152AbSJWTDu>; Wed, 23 Oct 2002 15:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265153AbSJWTDu>; Wed, 23 Oct 2002 15:03:50 -0400
Received: from server.s8.com ([66.77.12.139]:15882 "EHLO server.s8.com")
	by vger.kernel.org with ESMTP id <S265152AbSJWTDt>;
	Wed, 23 Oct 2002 15:03:49 -0400
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0210222237180.22860-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210222237180.22860-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Oct 2002 12:09:52 -0700
Message-Id: <1035400192.13194.2.camel@plokta.s8.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 13:42, Ingo Molnar wrote:

> I think ext2/ext3fs's current 2Tb/4Tb limit is a much
> bigger problem, you cannot compile around that - are there any patches in
> fact that lift that limit? (well, one solution is to use another
> filesystem.)

Peter Chubb's sector_t changes effectively raise this to an 8TB limit in
2.5.x.  The limit would be 16TB, but ext3 and jbd are rather cavalier
with casting block offsets between int, long, and unsigned long. 
Changes to fix that would be highly intrusive.

	<b

