Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274824AbTHFD6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 23:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274846AbTHFD6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 23:58:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37366 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S274824AbTHFD6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 23:58:23 -0400
Subject: Re: [patch] real-time enhanced page allocator and throttling
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       piggin@cyberone.com.au, kernel@kolivas.org, linux-mm@kvack.org
In-Reply-To: <20030805174536.6cb5fbf0.akpm@osdl.org>
References: <1060121638.4494.111.camel@localhost>
	 <20030805170954.59385c78.akpm@osdl.org>
	 <1060130368.4494.166.camel@localhost>
	 <20030805174536.6cb5fbf0.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1060142290.4494.197.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 05 Aug 2003 20:58:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 17:45, Andrew Morton wrote:

> It's testing time.

Just via some instrumenting, I can see that a real-time task never
begins throttling and this translates to a ~1ms reduction in worst case
allocation on a fast machine latency under extreme page dirtying and
writeback (basically, I cannot reproduce any variation in page
allocation, now, for a real-time test app). So it works.

But I do not have any real world test to confirm a benefit, which is
what matters. Have you poked and prodded?

	Robert Love


