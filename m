Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312997AbSDYJSE>; Thu, 25 Apr 2002 05:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSDYJSD>; Thu, 25 Apr 2002 05:18:03 -0400
Received: from surf.viawest.net ([216.87.64.26]:31390 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S312997AbSDYJSC>;
	Thu, 25 Apr 2002 05:18:02 -0400
Date: Thu, 25 Apr 2002 02:17:55 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.9-dj1, fix for make xconfig in drivers/isdn/Config.in
Message-ID: <20020425091755.GA9549@wizard.com>
In-Reply-To: <1019619120.29017.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 2:09am  up 23:17,  2 users,  load average: 0.52, 0.21, 0.08
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 09:31:59PM -0600, Steven Cole wrote:
> I read that some of you got this while doing make xconfig.
> 
> [steven@localhost linux-2.5.9-dj1]$ make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/home/steven/kernels/linux-2.5.9-dj1/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/isdn/Config.in: 10: incorrect argument
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/home/steven/kernels/linux-2.5.9-dj1/scripts'
> make: *** [xconfig] Error 2
> 
> This fix seems to be the obvious one.

        This is definitely the right fix, now that I compare what I threw to 
the list earlier, to the other Config.in scripts in the tree. Plus, this 
applies to a vanilla 2.5.10.

        Linus, Dave, please consider applying.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

