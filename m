Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbRAYP5A>; Thu, 25 Jan 2001 10:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130933AbRAYP4k>; Thu, 25 Jan 2001 10:56:40 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:23023 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130887AbRAYP4g>; Thu, 25 Jan 2001 10:56:36 -0500
Date: Thu, 25 Jan 2001 09:56:32 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010125151655.V11607@redhat.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
	<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Message-Id: <20010125155638Z130887-18594+1345@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Stephen C. Tweedie" <sct@redhat.com> on Thu, 25 Jan
2001 15:16:55 +0000


> ioremap*() is only supposed to be used on IO regions or reserved
> pages.  If you haven't marked the pages as reserved, then iounmap will
> do the wrong thing, so it's up to you to reserve the pages.

Au contraire!

I mark the page as reserved when I ioremap() it.  However, if I leave it marked
reserved, then iounmap() will not unmap it.  If I mark it "unreserved" (i.e.
reset the reserved bit), then iounmap will unmap it, but it will decrement the
page counter to -1 and the whole system will crash soon thereafter.

I've been asking about this problem for months, but no one has bothered to help
me out.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
