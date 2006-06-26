Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWFZR6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWFZR6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWFZR6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:58:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:26794 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751236AbWFZR6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:58:17 -0400
Subject: Re: [PATCH] Clean up the bootmem allocator
From: Dave Hansen <haveblue@us.ibm.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <449FDD02.2090307@innova-card.com>
References: <449FDD02.2090307@innova-card.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 10:58:11 -0700
Message-Id: <1151344691.10877.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 15:11 +0200, Franck Bui-Huu wrote:
> This patch does _only_ some cleanup in the bootmem allocator by:
...
>  include/linux/bootmem.h |  101 ++++++++++++++----------
>  mm/bootmem.c            |  195 ++++++++++++++++++++++++++---------------------
>  2 files changed, 167 insertions(+), 129 deletions(-)

I'm always suspicious of "cleanups" which add more code than they remove ;)

>         - following the kernel coding style conventions

Above everything else, this probably needs to be in its very own patch,
where it is trivially verifiable. 

>         - using pfn/page conversion macros
>         - removing some not needed parentheses
>         - removing some useless included headers
>         - limiting to 80 column width

In general, I think there is some good stuff in here.  However, instead
of concentrating on "kernel coding style conventions" and numeric (80
column) guidelines, I really hope that people consider _readability_
when modifying this code.  I don't think this patch makes the code much
more readable.

That said, there are some nice helper function in here.  Would you be
able to break this patch up into maybe 10 or 15 smaller patches?  I have
the feeling it will be easier to find the good bits then.

> It also removes __init tags in the header file and hopefully make it
> easier to read. 

I think I kinda like when these are present in headers.  I usually
stumble across the header declarations before I do the ones in the .c
files, and it is always nice to see the header visually _matching_
the .c file, and how the variable is intended to be used


-- Dave

