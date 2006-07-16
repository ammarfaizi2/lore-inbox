Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWGPUlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWGPUlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGPUlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:41:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57093 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751202AbWGPUk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:40:59 -0400
Date: Sun, 16 Jul 2006 22:40:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>, sam@ravnborg.org
Cc: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc2
Message-ID: <20060716204057.GB22759@stusta.de>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org> <20060716194134.GB17387@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716194134.GB17387@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 09:41:34PM +0200, Olaf Hering wrote:
> 
> > David Woodhouse:
> >       [SPARC64]: Fix make headers_install
> >       hdrinstall: remove asm/irq.h from user visibility
> >       hdrinstall: remove asm/atomic.h from user visibility
> >       hdrinstall: remove asm/io.h from user visibility
> 
> Why does the 'headers_install' target require a configured kernel?
> I just ran 'make headers_install INSTALL_HDR_PATH=/dev/shm/$$'

It installs linux/version.h that is generated.

But you are right, can't the rules for the version.h generation be more 
relaxed?
Sam?

> Unrelated:
> Cant you just export all asm-<arch> files? I guess they are all static.

asm/atomic.h is a good example for abuses that are prevented by not 
installing all asm-<arch> files.

For more information, please refer to the long discussion about this 
topic currently taking place on this mailing list.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

