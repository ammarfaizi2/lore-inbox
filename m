Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271192AbTGPWua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTGPWu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:50:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10745 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271192AbTGPWtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:49:41 -0400
Date: Thu, 17 Jul 2003 01:04:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, Michael Hunold <michael@mihu.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-ac2: multiple definitions of hexium_*
Message-ID: <20030716230425.GB1407@fs.tum.de>
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:16:20PM -0400, Alan Cox wrote:

> 2.6.0-test1-ac2
>...
> o	DVB resync					(Michael Hunold)
>...

I got the following compile error:

<--  snip  -->

...
  LD      drivers/media/video/built-in.o
drivers/media/video/hexium_gemini.o(.data+0x4): multiple definition of 
`hexium_num'
drivers/media/video/hexium_orion.o(.data+0x4): first defined here
drivers/media/video/hexium_gemini.o(.init.text+0x0): In function 
`hexium_init_module':
: multiple definition of `hexium_init_module'
drivers/media/video/hexium_orion.o(.init.text+0x0): first defined here
drivers/media/video/hexium_gemini.o(.exit.text+0x0): In function 
`hexium_cleanup_module':
: multiple definition of `hexium_cleanup_module'
drivers/media/video/hexium_orion.o(.exit.text+0x0): first defined here
make[3]: *** [drivers/media/video/built-in.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

