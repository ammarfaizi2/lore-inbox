Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUBCAlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUBCAlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:41:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:12680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264310AbUBCAlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:41:09 -0500
Date: Mon, 2 Feb 2004 16:42:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: roland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in
 get_user_pages
Message-Id: <20040202164230.704e75c1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
References: <200402030009.i1309TeY016316@magilla.sf.frob.com>
	<Pine.LNX.4.58.0402021616340.9720@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> mark the "struct page" dirty with SetPageDirty()

set_page_dirty(), please.  It takes care of list motion and dirty page
accounting.


