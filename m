Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTEWJIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTEWJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:08:51 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:12570 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263969AbTEWJIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:08:50 -0400
Date: Fri, 23 May 2003 02:24:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Lothar Wassmann" <LW@KARO-electronics.de>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
Message-Id: <20030523022454.61a180dd.akpm@digeo.com>
In-Reply-To: <16077.55787.797668.329213@ipc1.karo>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
	<16077.55787.797668.329213@ipc1.karo>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 09:21:56.0522 (UTC) FILETIME=[C170B8A0:01C3210C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lothar Wassmann" <LW@KARO-electronics.de> wrote:
>
> And maybe because *every* other call to flush_page_to_ram() has been
>  replaced by one of the new interface macros except that one in
>  filemap_nopage() in 'mm/filemap.c'.
> 

flush_page_to_ram() has been deleted from the kernel.

filemap_nopage() is a pagecache function and shouldn't be fiddling with
cache and/or TLB operations.  Unless it touches the page by hand, which it
does not.

Please, test a current kernel.


