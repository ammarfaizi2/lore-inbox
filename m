Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTDXLZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTDXLZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:25:35 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:37300 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263349AbTDXLZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:25:33 -0400
Date: Thu, 24 Apr 2003 13:36:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@suse.cz>,
       cat@zip.com.au, mbligh@aracnet.com, gigerstyle@gmx.ch,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
In-Reply-To: <1051182797.2250.10.camel@laptop-linux>
Message-ID: <Pine.GSO.4.21.0304241335210.19942-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Nigel Cunningham wrote:
> On Thu, 2003-04-24 at 21:46, Andrew Morton wrote:
> > > > Sorry, I still don't get it.  Go through the steps for me:
> > > > 
> > > > 1) suspend writes pages to disk
> > > > 
> > > > 2) machine is shutdown
> > > > 
> > > > 3) restart, journal replay
> 
> Corruption comes here. The journal reply tidies things up that shouldn't
> be tidied up. They shouldn't be tidied up because once we reload the
> image, things should be in the same state as prior to suspend. If replay
> frees a block (thinking it wasn't properly linked or something similar),
> it introduces corruption.

This has nothing to do with using a swapfile.

But if you resume from swsusp, you don't really `mount' all file systems. They
are implicitly mounted because they were mounted before the suspend operation.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

