Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUFPREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUFPREq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUFPRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:00:48 -0400
Received: from witte.sonytel.be ([80.88.33.193]:59573 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264176AbUFPQ6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:58:19 -0400
Date: Wed, 16 Jun 2004 18:57:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Perlbroker <minime@sdf.lonestar.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.6.7 does not compile (jfs errors)
In-Reply-To: <1087403262.29041.25.camel@shaggy.austin.ibm.com>
Message-ID: <Pine.GSO.4.58.0406161856190.1249@waterleaf.sonytel.be>
References: <20040616133944.GA1987@8128.biz> <1087403262.29041.25.camel@shaggy.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Dave Kleikamp wrote:
> On Wed, 2004-06-16 at 08:39, Perlbroker wrote:
> > CC [M]  fs/jfs/jfs_dtree.o
> > fs/jfs/jfs_dtree.c: In function `add_index':
> > fs/jfs/jfs_dtree.c:388: parse error before `struct'
> > fs/jfs/jfs_dtree.c:389: `temp_table' undeclared (first use in this function)
> > fs/jfs/jfs_dtree.c:389: (Each undeclared identifier is reported only once
> > fs/jfs/jfs_dtree.c:389: for each function it appears in.)
> > make[3]: *** [fs/jfs/jfs_dtree.o] Error 1
> > make[2]: *** [fs/jfs] Error 2
> > make[1]: *** [fs] Error 2
> > make[1]: Leaving directory `/usr/src/linux-2.6.7'
>
> This was reported in another thread by Tomas Szepe.  I don't know why
> this sometimes compiles cleanly, but this patch should fix it:

Because newer gcc allows declarations of variables between statements, while
older doesn't?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
