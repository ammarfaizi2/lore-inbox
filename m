Return-Path: <linux-kernel-owner+w=401wt.eu-S1423157AbWLVA4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423157AbWLVA4K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423173AbWLVA4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:56:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59358 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423157AbWLVA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:56:08 -0500
Date: Thu, 21 Dec 2006 16:54:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: export cancel_dirty_page()
In-Reply-To: <20061221233018.GA28046@elte.hu>
Message-ID: <Pine.LNX.4.64.0612211652580.3536@woody.osdl.org>
References: <20061221231328.GA21217@elte.hu> <20061221232850.GJ6993@stusta.de>
 <20061221233018.GA28046@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Dec 2006, Ingo Molnar wrote:
> 
> ah, indeed - but i dont see a fundamental reason why hugetlbfs is not 
> modular. Nevertheless exporting this makes sense. My quick hack below to 
> guess to convert reiserfs (just to make the rpm build) also needs it.

Yes, it should be exported regardless.

Hoiwever, I'm not sure your reiserfs change is valid: why was that old 
code testing "PAGE_SIZE == bh->b_size"?

(Not that I see why the _old_ code would be valid either, and why you'd 
ever care about b_size being PAGE_SIZE, but I'm just wondering..)

		Linus
