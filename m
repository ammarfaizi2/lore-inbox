Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267914AbTBELDb>; Wed, 5 Feb 2003 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbTBELDb>; Wed, 5 Feb 2003 06:03:31 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:45316 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267914AbTBELDa>; Wed, 5 Feb 2003 06:03:30 -0500
Date: Wed, 5 Feb 2003 14:12:25 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030205141225.A2128@jurassic.park.msu.ru>
References: <20030129190647.A689@jurassic.park.msu.ru> <Pine.LNX.4.44.0301291813330.22973-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301291813330.22973-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Jan 29, 2003 at 06:15:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 06:15:36PM +0000, James Simmons wrote:
> As a small note I really like to move vagcon.c to start to use the inline 
> functions in include/video/vga.h. I have provisions to even use a specific 
> register base region. I like to combine it with your work.

Unfortunately, these functions won't work "as is" on all architectures.
Even if the IO port space is mapped somewhere in the CPU memory space,
this doesn't mean that the mapping is linear - look at parisc inX/outX
functions, for example.
In other words, you cannot portably use readX/writeX instead of inX/outX.

Ivan.
