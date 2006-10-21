Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWJUBze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWJUBze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWJUBze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:55:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:4992 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030377AbWJUBzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:55:33 -0400
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <452C8613.7080708@yahoo.com.au>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	 <20061010121332.19693.37204.sendpatchset@linux.site>
	 <20061010221304.6bef249f.akpm@osdl.org>  <452C8613.7080708@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 11:53:25 +1000
Message-Id: <1161395605.10524.227.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Without looking at any code, perhaps we could instead run get_user_pages
> and copy the memory that way.

I have a deep hatred for get_user_pages().... maybe not totally rational
though :) It will also only work with things that are actually backed up
by struct page. Is that ok in your case ?

Ben.


