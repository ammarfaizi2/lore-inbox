Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVAXRHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVAXRHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVAXRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:07:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261151AbVAXREP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:04:15 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk> 
References: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk> 
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@zip.com.au>, linux-mm@kvack.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make slab use alloc_pages directly 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 24 Jan 2005 17:03:58 +0000
Message-ID: <24391.1106586238@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <matthew@wil.cx> wrote:

> __get_free_pages() calls alloc_pages, finds the page_address() and
> throws away the struct page *.  Slab then calls virt_to_page to get it
> back again.  Much more efficient for slab to call alloc_pages itself,
> as well as making the NUMA and non-NUMA cases more similarr to each other.

Looks reasonable. Should also work in the NOMMU case.

David
