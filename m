Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWHJEn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWHJEn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 00:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWHJEn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 00:43:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44419 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161019AbWHJEn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 00:43:57 -0400
Date: Thu, 10 Aug 2006 13:46:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: apw@shadowen.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Re : Re : Re : Re : sparsemem usage
Message-Id: <20060810134616.31268991.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060809141901.40003.qmail@web25814.mail.ukl.yahoo.com>
References: <44D1F688.2030806@shadowen.org>
	<20060809141901.40003.qmail@web25814.mail.ukl.yahoo.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 14:19:01 +0000 (GMT)
moreau francis <francis_moreau2000@yahoo.fr> wrote:

> Not all arch have page_is_ram(). OK it should be easy to have but we will
> need create new data structures to keep this info. The point is that it's
> really easy for memory model such sparsemem to keep this info.
> 
> > Do you have a usage model in which we really care about the number of
> > pages in the system to that level of accuracy?
> > 
> 
> show_mem(), which is arch specific, needs to report them. And some
> implementations use only pfn_valid().
> 

BTW, ioresouce information (see kernel/resouce.c)

[kamezawa@aworks Development]$ cat /proc/iomem | grep RAM
00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
00100000-2dfeffff : System RAM

is not enough ?

I think kdump depends on this resouce information to determine 
where should be dumped.

-Kame


