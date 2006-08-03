Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWHCJUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWHCJUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWHCJUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:20:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25046 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932414AbWHCJUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:20:40 -0400
Date: Thu, 3 Aug 2006 18:19:09 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: Re : Re : sparsemem usage
Message-Id: <20060803181909.928b913b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060803090706.99884.qmail@web25813.mail.ukl.yahoo.com>
References: <20060803090706.99884.qmail@web25813.mail.ukl.yahoo.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 09:07:06 +0000 (GMT)
moreau francis <francis_moreau2000@yahoo.fr> wrote:

> Alan Cox wrote:
> >
> > Mapping out parts of a section is quite normal - think about the 640K to
> > 1Mb hole in PC memory space.
> 
> OK. But I'm still worry. Please consider the following code
> 
>        for (...; ...; ...) {
>                 [...]
>                 if (pfn_valid(i))
>                        num_physpages++;
>                 [...]
>         }
> 
> In that case num_physpages won't store an accurate value. Still it will be
> used by the kernel to make some statistic assumptions on other kernel
> data structure sizes.
> 
In my understanding, pfn_valid() just returns "the page has page struct or not".
So, don't use pfn_valid() to count physical pages..


-Kame

