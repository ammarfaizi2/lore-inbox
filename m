Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUJXJeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUJXJeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUJXJeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:34:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39953 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261400AbUJXJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:34:11 -0400
Date: Sun, 24 Oct 2004 11:33:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Hinds <dahinds@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org, prism54-devel@prism54.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-mm1: pc_debug multiple definitions
Message-ID: <20041024093340.GA4216@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022133929.GA2831@stusta.de> <20041024034152.GB17506@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024034152.GB17506@ruslug.rutgers.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 11:41:52PM -0400, Luis R. Rodriguez wrote:
> On Fri, Oct 22, 2004 at 03:39:29PM +0200, Adrian Bunk wrote:
> > 
> > The following compile error comes from Linus' tree:
> > 
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      drivers/built-in.o
> > drivers/pcmcia/built-in.o(.bss+0xf20): multiple definition of `pc_debug'
> > drivers/net/built-in.o(.data+0x24ae0): first defined here
> > make[1]: *** [drivers/built-in.o] Error 1
> > 
> > <--  snip  -->
> > 
> > 
> > The pc_debug in drivers/pcmcia/ds.c was made non-static in Linus' tree,
> > but the global definition of a global variable with such a generic name 
> > in drivers/net/wireless/prism54/islpci_mgt.c seems to be equally wrong.
> 
> Great, anyone know why this change was done on ds.c ? The pc_debug on
> prism54 comes from the original Intersil driver. It is used to for
> debugging but we should move away from our current debugging mechanism
> to netif_msg.
>...

pc_debug is a pretty generic name - it seems too generic in both files.

In prism54, couldn't it be called prism54_pc_debug?

> 	Luis

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

