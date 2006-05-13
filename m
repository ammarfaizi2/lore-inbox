Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWEMMNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWEMMNK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWEMMNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:13:10 -0400
Received: from [83.101.159.136] ([83.101.159.136]:55051 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932399AbWEMMNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:13:09 -0400
From: Al Boldi <a1426z@gawab.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: swapping and oom-killer: gfp_mask=0x201d2, order=0
Date: Sat, 13 May 2006 15:11:05 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200605111514.45503.a1426z@gawab.com> <200605121517.59988.a1426z@gawab.com> <1147447913.7520.6.camel@homer>
In-Reply-To: <1147447913.7520.6.camel@homer>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200605131511.05723.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-05-12 at 15:17 +0300, Al Boldi wrote:
> > Note that this is not specific to mem=8M, but rather a general oom
> > observation even for mem=4G, where it is only much later to occur.
>
> An oom situation with 4G ram would be more interesting than this one.

Agreed, but can you tell me what readahead has to do with this oom?

oom-killer: gfp_mask=0x201d2, order=0
 [<c013ff25>] out_of_memory+0xa5/0xc0
 [<c0141099>] __alloc_pages+0x279/0x310
 [<c0143669>] __do_page_cache_readahead+0xe9/0x120
 [<c0143b3f>] max_sane_readahead+0x2f/0x50
 [<c013d8cb>] filemap_nopage+0x2eb/0x370
 [<c0149ea5>] do_no_page+0x65/0x220
 [<c014a1dc>] __handle_mm_fault+0xec/0x200
 [<c0113258>] do_page_fault+0x188/0x5c5
 [<c01130d0>] do_page_fault+0x0/0x5c5
 [<c0103a0f>] error_code+0x4f/0x54

Thanks!

--
Al

