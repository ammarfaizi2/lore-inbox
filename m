Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVAXRqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVAXRqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVAXRqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:46:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63494 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261538AbVAXRqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:46:02 -0500
Date: Mon, 24 Jan 2005 18:45:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: v4l-saa7134-module compile error
Message-ID: <20050124174559.GJ3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124111713.GF3515@stusta.de> <20050124135716.GA23702@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124135716.GA23702@bytesex>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:57:17PM +0100, Gerd Knorr wrote:
> On Mon, Jan 24, 2005 at 12:17:13PM +0100, Adrian Bunk wrote:
> > On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> > >...
> > > +v4l-saa7134-module.patch
> > 
> > This patch broke compilation with CONFIG_MODULES=n:
> > 
> > drivers/media/video/saa7134/saa7134-core.c: In function `pending_call':
> > drivers/media/video/saa7134/saa7134-core.c:234: error: `MODULE_STATE_LIVE' undeclared (first use in this function)
> 
> The patch below should fix this.

Not completely:

<--  snip  -->

...
  CC      drivers/media/video/saa7134/saa7134-core.o
drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_initdev':
drivers/media/video/saa7134/saa7134-core.c:997: error: `need_empress' undeclared (first use in this function)
drivers/media/video/saa7134/saa7134-core.c:997: error: (Each undeclared identifier is reported only once
drivers/media/video/saa7134/saa7134-core.c:997: error: for each function it appears in.)
drivers/media/video/saa7134/saa7134-core.c:1000: error: `need_dvb' undeclared (first use in this function)
make[4]: *** [drivers/media/video/saa7134/saa7134-core.o] Error 1

<--  snip  -->

>   Gerd
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

