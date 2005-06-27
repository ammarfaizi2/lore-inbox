Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVF0HrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVF0HrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVF0HrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:47:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261896AbVF0Hqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:46:52 -0400
Date: Mon, 27 Jun 2005 00:46:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
Message-Id: <20050627004624.53f0415e.akpm@osdl.org>
In-Reply-To: <42BF9CD1.2030102@yahoo.com.au>
References: <42BF9CD1.2030102@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> First I'll put up some numbers to get you interested - of a 64-way Altix
>  with 64 processes each read-faulting in their own 512MB part of a 32GB
>  file that is preloaded in pagecache (with the proper NUMA memory
>  allocation).

I bet you can get a 5x to 10x reduction in ->tree_lock traffic by doing
16-page faultahead.

