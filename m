Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264572AbUENX7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbUENX7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUENX4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:56:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:50383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264632AbUENXsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:48:11 -0400
Date: Fri, 14 May 2004 16:50:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: torvalds@osdl.org, hugh@veritas.com,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
Message-Id: <20040514165038.17eb142b.akpm@osdl.org>
In-Reply-To: <40A55647.8020904@yahoo.com.au>
References: <40A42892.5040802@yahoo.com.au>
	<20040513193328.11479d3e.akpm@osdl.org>
	<40A43152.4090400@yahoo.com.au>
	<40A438AC.9020506@yahoo.com.au>
	<40A55647.8020904@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> I think the entire problem can be fixed by ensuring ->readpage and
> do_generic_mapping read see the same i_size. This would either mean
> passing i_size to or from ->readpage, *or* having ->readpage return
> the number of bytes read, for example.

Or not check i_size in ->readpage at all?

If fixing this is going to cost extra fastpath cycles I'd be inclined to
not bother, frankly.
