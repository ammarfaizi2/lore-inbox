Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTIVLN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTIVLN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:13:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15808 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263071AbTIVLN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:13:57 -0400
Date: Mon, 22 Sep 2003 13:13:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move some more intilization out of drivers/char/mem.c
Message-ID: <20030922111349.GO6325@fs.tum.de>
References: <20030920132900.GC23153@lst.de> <20030920160645.30c2745d.akpm@osdl.org> <20030921063030.GA1508@lst.de> <20030920234853.7e09f663.akpm@osdl.org> <20030921075430.GA4938@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921075430.GA4938@actcom.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:54:30AM +0300, Muli Ben-Yehuda wrote:
> On Sat, Sep 20, 2003 at 11:48:53PM -0700, Andrew Morton wrote:
> > Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > > Please compile-test things...
> > > 
> > >  Well, I compiled this here.  I see, looks like I lost half of the patch
> > >  when sending it to you.  Sorryh for that, here's the full patch:
> > 
> > It still generates warnings.  I suggest you build kernels with a script
> > which saves up stderr and spits it all out at the end.  That way, these
> > things are noticed.
> 
> This might be a good time to recommend -Werror. Last time it came up
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=102654562025374&w=2),
> Alan was dead set against it, and Linus did not apply it, but did
> think it had some merit
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=102658611213914&w=2). 
> 
> Compiling 2.6.0-t5-cvs with my .config and -Werror uncovered only two
> warnings. Patches sent seperately. 
>...

In 2.6, warnings are very visible, and many people are working on 
reducing the number of warning.

A full build of 2.6 gives between 200 and 300 warnings with gcc 3.3 
including harmless ones.

You get several "unused variable" warnings when you disable e.g.
CONFIG_PROC_FS.

When compiling with a different compiler version (e.g. 2.95) you get a 
similar number of warnings, but different warnings.

Some warnings are the fault of gcc (and noone will fix gcc 2.95 or the 
unofficial gcc 2.96).


Adding -Werror will turn into a maintenance nightmare.


> Muli Ben-Yehuda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

