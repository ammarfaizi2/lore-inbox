Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUG3OO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUG3OO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267688AbUG3OO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:14:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9455 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267686AbUG3OOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:14:49 -0400
Date: Fri, 30 Jul 2004 16:14:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Grega Fajdiga <Gregor.Fajdiga@guest.arnes.si>,
       Nicolas Boichat <nicolas@boichat.ch>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Compile error in 2.6.8-rc2-mm1 - rivafb related
Message-ID: <20040730141441.GA685@fs.tum.de>
References: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 02:52:25PM +0200, Grega Fajdiga wrote:

> Good day,

Hi Grega,

> Please CC me, since I'm not subscribed. 
> I just tried to compile 2.6.8-rc2-mm1 and got this error:
> drivers/built-in.o(.text+0x7e369): In function `rivafb_probe'::
> undefined reference to `riva_create_i2c_busses'
> drivers/built-in.o(.text+0x7e4c1): In function `rivafb_probe'::
> undefined reference to `riva_delete_i2c_busses'
> drivers/built-in.o(.exit.text+0x1ca): In function `rivafb_remove'::
> undefined reference to `riva_delete_i2c_busses'
> make: *** [.tmp_vmlinux1] Error 1
>...

thanks for this report.

@Nicolas:
Your rivafb-i2c-fixes patch in -mm causes this with CONFIG_FB_RIVA_I2C=n 
(it moves i2c code from inside an #ifdef CONFIG_FB_RIVA_I2C to a place 
where it isn't guarded by such an #ifdef).

> Thanks,
> Grega

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

