Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTKVMy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 07:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTKVMyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 07:54:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46274 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262251AbTKVMyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 07:54:23 -0500
Date: Sat, 22 Nov 2003 13:54:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Buck Rekow <rekow@bigskytel.com>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net
Subject: Re: PROBLEM: Aironet compile failure 2.6-test9/Alpha architecture
Message-ID: <20031122125417.GP16828@fs.tum.de>
References: <3FBD67E7.5020405@bigskytel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBD67E7.5020405@bigskytel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 06:18:31PM -0700, Buck Rekow wrote:

>  Aironet is not listed as i can find in the file MAINTAINERS, however, 
> This report needs to go somewhere and do something. The maintainer is 
> however listed in airo.c. merry carbon-copy, people.
> 
> Quite simply, the compile fails with the following error.   I'm not sure 
> anyone else  is using an aironet card under Alpha, so I guess someone 
> needs to report this.
> I must say Aironet can be a real pain.
> 
> predator:/usr/src/linux-2.6.0-test9# make modules
> make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
>  CC [M]  drivers/net/wireless/airo.o
> drivers/net/wireless/airo.c: In function `emmh32_setseed':
> drivers/net/wireless/airo.c:1458: internal error--unrecognizable insn:
> (insn:TI 512 478 513 (set (reg:DI 1 $1)
>        (plus:DI (reg:DI 30 $30)
>            (const_int 4398046511104 [0x40000000000]))) -1 (insn_list 51 
> (insn_list:REG_DEP_ANTI 494 (nil)))
>    (nil))
> cpp0: output pipe has been closed
> make[3]: *** [drivers/net/wireless/airo.o] Error 1
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> Here is the output of ver_linux
> Gnu C                  2.95.4
>...
> There is a possibility this may be caused by GCC bug PR-9164, which is 
> present in debian 3.0  Alpha (Debian people: READ: *fix it*)  which I am 
> running.    
> 
>  Hope this is fixable.

This is a bug in the compiler, but the gcc developers stopped any 
development on 2.95 long time ago.

Besides the fact that you'd have to wait half a year (or maybe two
years) until Debian 3.1 releases to get the fix if it was fixed, I doubt
anyone of the Debian gcc maintainers would spend his time on fixing bugs 
in gcc 2.95 .

You might have luck with trying to use the gcc-3.0 in stable to compile 
your kernel, but since I doubt anyone backported gcc 3.2 or 3.3 for 
alpha to the pretty ancient Debian stable it might be that the only way 
to get kernel 2.6 running for you would be to try to locally modify 
airo.c in a way that your gcc compiles it.

>    Buck Rekow

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

