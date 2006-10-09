Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWJIDey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWJIDey (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWJIDey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:34:54 -0400
Received: from xenotime.net ([66.160.160.81]:32192 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932221AbWJIDex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:34:53 -0400
Date: Sun, 8 Oct 2006 20:36:17 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] kernel-doc: fix function name in usercopy.c
Message-Id: <20061008203617.f3ca1270.rdunlap@xenotime.net>
In-Reply-To: <20061009032851.GA5344@martell.zuzino.mipt.ru>
References: <20061008194429.c98d7387.rdunlap@xenotime.net>
	<20061009032851.GA5344@martell.zuzino.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 07:28:51 +0400 Alexey Dobriyan wrote:

> On Sun, Oct 08, 2006 at 07:44:29PM -0700, Randy Dunlap wrote:
> >  /**
> > - * strlen_user: - Get the size of a string in user space.
> > + * strnlen_user: - Get the size of a string in user space.
> 
> It's better to not spend time fixing mismatches, but to teach kernel-doc
> extract function name from function itself.
> 
> 	/**
> 	 * Get the size of a string in user space.
> 	 * @foo: bar
> 	 */
> 	 size_t strnlen_user()

OK, maybe a good idea.  I'll add that to the wish list.
However, we have seen examples of:

/**
 * doc for foo
 */
int foo(int arg)
{
}

then someone inserts a new function bar() between the kernel-doc
and foo().  How would we catch that (automated)?
other than by our review process?

---
~Randy
