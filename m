Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbUKTTRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbUKTTRy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUKTTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:16:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:14256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263158AbUKTTQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:16:22 -0500
Date: Sat, 20 Nov 2004 11:16:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       clameter@sgi.com, benh@kernel.crashing.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
In-Reply-To: <20041120190818.GX2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0411201112200.20993@ppc970.osdl.org>
References: <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au>
 <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au>
 <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au>
 <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au>
 <1834180000.1100969975@[10.10.2.4]> <Pine.LNX.4.58.0411200911540.20993@ppc970.osdl.org>
 <20041120190818.GX2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Nov 2004, William Lee Irwin III wrote:
> 
> "The perfect is the enemy of the good."

Yes. But in this case, my suggestion _is_ the good. You seem to be pushing 
for a really horrid thing which allocates a per-cpu array for each 
mm_struct. 

What is it that you have against the per-thread rss? We already have 
several places that do the thread-looping, so it's not like "you can't do 
that" is a valid argument.

		Linus
