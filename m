Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSGWUax>; Tue, 23 Jul 2002 16:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSGWUax>; Tue, 23 Jul 2002 16:30:53 -0400
Received: from [195.223.140.120] ([195.223.140.120]:34097 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318248AbSGWUau>; Tue, 23 Jul 2002 16:30:50 -0400
Date: Tue, 23 Jul 2002 22:34:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: David F Barrera <dbarrera@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0, mode:0x0
Message-ID: <20020723203445.GK1117@dualathlon.random>
References: <OF6F39340B.FF1F1097-ON85256BFF.005C6460@pok.ibm.com> <3D3DAD54.6825F86@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3DAD54.6825F86@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 12:24:04PM -0700, Andrew Morton wrote:
> David F Barrera wrote:
> > 
> > I have experienced the following errors while running a test suite (LTP
> > test suite)  on the 2.4.26 kernel.  Has anybody seen this problem, and, if
> > so, is there a patch for it?  Thanks.
> > 
> > kernel BUG at page_alloc.c:92!
> 
> Could you please replace the put_page(page) in
> kernel/ptrace.c:access_process_vm() with page_cache_release(page)
> and retest?

I prefer to drop page_cache_release and to have __free_pages_ok to deal
with the lru pages like it's been fixed in 2.4. 

Andrea
