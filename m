Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTKRVHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 16:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTKRVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 16:07:24 -0500
Received: from sun3.sammy.net ([68.162.198.6]:62472 "HELO sun3.sammy.net")
	by vger.kernel.org with SMTP id S263793AbTKRVHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 16:07:22 -0500
Date: Wed, 19 Nov 2003 17:08:01 -0500 (EST)
From: Sam Creasey <sammy@sammy.net>
X-X-Sender: sammy@sun3
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [BK PATCHES] 2.6.x experimental net driver queue
In-Reply-To: <Pine.GSO.4.21.0311181205460.6448-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.40.0311191703120.6278-100000@sun3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Nov 2003, Geert Uytterhoeven wrote:

> On Mon, 17 Nov 2003, Geert Uytterhoeven wrote:
> > On Sun, 16 Nov 2003, Jeff Garzik wrote:
> > > Yet more updates.  Syncing with Andrew Morton, and more syncing with Al
> > > Viro.
> > >
> > > No users of init_etherdev remain in the tree.  (yay!)
> >
> > Here are some (untested, except for cross-gcc) fixes for the m68k-related
> > drivers:
>
> I forget to test the Sun-3 drivers:
>   - sun3_82586.c:
>       o add missing casts to iounmap() calls
>       o fix parameter of free_netdev()
>   - sun3lance.c: add missing casts to iounmap() calls
>
> Note that sun3_82586.c no longer compiles since SUN3_82586_TOTAL_SIZE is not
> defined. Sammy, is it OK to use PAGE_SIZE for that, since that's what's passed
> to ioremap()?

Should be...  I looked back through a few versions of the code, and I'm
not even sure what SUN3_82586_TOTAL_SIZE even was (appears I commented
that line out long ago anyway).  (I'm also amazed just how much of that
driver I've forgotten in the last year or two :)

-- Sam


