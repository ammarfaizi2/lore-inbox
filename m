Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131209AbRCRMem>; Sun, 18 Mar 2001 07:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbRCRMed>; Sun, 18 Mar 2001 07:34:33 -0500
Received: from www.wen-online.de ([212.223.88.39]:62480 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131209AbRCRMeZ>;
	Sun, 18 Mar 2001 07:34:25 -0500
Date: Sun, 18 Mar 2001 13:33:42 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <Pine.LNX.4.21.0103180742510.13050-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0103181331420.1332-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Rik van Riel wrote:

> > VFS: Mounted root (ext2 filesystem) readonly.
> > Freeing unused kernel memory: 196k freed
> > Adding Swap: 265064k swap-space (priority 2)
> > VM: Bad swap entry 00011e00
> > VM: Bad swap entry 00058d00
> > Unused swap offset entry in swap_dup 00058d00
> > Unused swap offset entry in swap_dup 00011e00
> > VM: Bad swap entry 00011e00
> > VM: Bad swap entry 00058d00
>
> Heh, I guess do_swap_page isn't too happy when multiple threads
> of the same program take a page fault at the same address at the
> same time.
>
> I take it you were testing something like mysql, jvm or apache2 ?

No, this was make -j30 bzImage.  (nscd was running though...)

	-Mike

