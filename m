Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTFHQmm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 12:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTFHQmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 12:42:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31681 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262850AbTFHQmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 12:42:37 -0400
Date: Sun, 8 Jun 2003 18:56:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>, Gergely Madarasz <gorgo@itc.hu>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030608165608.GI16164@fs.tum.de>
References: <20030608144038.GF16164@fs.tum.de> <20030608174908.A9377@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608174908.A9377@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 05:49:08PM +0100, Christoph Hellwig wrote:
> On Sun, Jun 08, 2003 at 04:40:38PM +0200, Adrian Bunk wrote:
> > >From drivers/net/wan/comx.c:
> > 
> > <--  snip  -->
> > 
> > ...
> > #ifndef CONFIG_PROC_FS
> > #error For now, COMX really needs the /proc filesystem
> > #endif
> > ...
> > 
> > <--  snip  -->
> > 
> > 
> > The following patch add a dependency to Kconfig to avoid compile errors 
> > with CONFIG_COMX and !CONFIG_PROC_FS:
> 
> Actually it still doesn't link with this because the procfs code in it
> is utter crap and relies on a symbol proc_get_inode that isn't exported
> since 2.3.  As no one cared for this driver over years I'd suggest just
> removing it.

The proc_get_inode link problem only affects the modular build of 
comx.c .

The static build works fine in both 2.4 and 2.5.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

