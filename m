Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYPTo>; Thu, 25 Jan 2001 10:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRAYPTd>; Thu, 25 Jan 2001 10:19:33 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7901 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129143AbRAYPTW>;
	Thu, 25 Jan 2001 10:19:22 -0500
Date: Thu, 25 Jan 2001 15:16:55 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
Message-ID: <20010125151655.V11607@redhat.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010123165117Z131182-221+34@kanga.kvack.org>; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 23, 2001 at 10:53:51AM -0600, Timur Tabi wrote:
> 
> My problem is that it's very easy to map memory with ioremap_nocache, but if
> you use iounmap() the un-map it, the entire system will crash.  No one has been
> able to explain that one to me, either.

ioremap*() is only supposed to be used on IO regions or reserved
pages.  If you haven't marked the pages as reserved, then iounmap will
do the wrong thing, so it's up to you to reserve the pages.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
