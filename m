Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265302AbUF1XQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbUF1XQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUF1XQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:16:52 -0400
Received: from ip214-49.coastside.net ([207.213.214.33]:25290 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S265302AbUF1XQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:16:50 -0400
Mime-Version: 1.0
Message-Id: <p0611043abd0656375755@[10.73.234.132]>
In-Reply-To: <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> 
 <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <1088268405.1942.25.camel@mulgrave> 
 <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
 <1088270298.1942.40.camel@mulgrave>
 <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
Date: Mon, 28 Jun 2004 16:16:43 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: [PATCH] Fix the cpumask rewrite
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:01 AM -0700 6/26/04, Linus Torvalds wrote:
>I'm saying that data structures ARE NOT VOLATILE. I personally believe
>that the notion of a "volatile" data structure is complete and utter shit.

Perhaps, but surely they exist. I'm thinking specifically of 
memory-mapped hardware registers and data structures that are shared 
with DMA devices. Most recent Ethernet controllers fall into the 
latter category, and in either case write-locking is not an option.

If I can find some way to force my code to reload the data, then 
sure, call the code "volatile" if you like. But the data is simply 
volatile, in the sense that it can (and is expected to) change 
independent of my code paths.
-- 
/Jonathan Lundell.
