Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269582AbUJVNkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269582AbUJVNkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUJVNkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:40:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56582 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269582AbUJVNkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:40:01 -0400
Date: Fri, 22 Oct 2004 15:39:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org,
       prism54-private@prism54.org, netdev@oss.sgi.com
Subject: 2.6.9-mm1: pc_debug multiple definitions
Message-ID: <20041022133929.GA2831@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following compile error comes from Linus' tree:


<--  snip  -->

...
  LD      drivers/built-in.o
drivers/pcmcia/built-in.o(.bss+0xf20): multiple definition of `pc_debug'
drivers/net/built-in.o(.data+0x24ae0): first defined here
make[1]: *** [drivers/built-in.o] Error 1

<--  snip  -->


The pc_debug in drivers/pcmcia/ds.c was made non-static in Linus' tree,
but the global definition of a global variable with such a generic name 
in drivers/net/wireless/prism54/islpci_mgt.c seems to be equally wrong.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

