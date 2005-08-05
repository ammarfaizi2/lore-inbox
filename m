Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVHEOGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVHEOGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVHEOGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:06:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23307 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263027AbVHEOGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:06:08 -0400
Date: Fri, 5 Aug 2005 16:06:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: George Van Tuyl <gvtlinux@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make modules Segfault
Message-ID: <20050805140604.GN4029@stusta.de>
References: <42F2DAF6.1040601@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F2DAF6.1040601@xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 09:20:22PM -0600, George Van Tuyl wrote:
> 
> To:  linux-kernel@vger.kernel.org
> 
> 
> 
> [1.] One line summary of the problem:
> 
>   make modules failed Segfault (program cpp0)
> 
> [2.] Full description of the problem/report:
> 
> gcc: Internal error: Segmentation fault (program cpp0)
> Please submit a full bug report.
> See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
> make[3]: *** [cycx_drv.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.31/drivers/net/wan'
> make[2]: *** [_modsubdir_wan] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.31/drivers/net'
> make[1]: *** [_modsubdir_net] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.31/drivers'
> make: *** [_mod_drivers] Error 2
> [root@wulff linux-2.4.31]# In file included from 
> /usr/src/linux-2.4.31/include/linux/vmalloc.h:5,
>                 from /usr/src/linux-2.4.31/include/asm/io.h:47,
>                 from cycx_drv.c:60:
> /usr/src/linux-2.4.31/include/linux/mm.h:155: parse error at end of input
> /usr/src/linux-2.4.31/include/linux/mm.h:155: warning: no semicolon at 
> end of struct or union
>...
> [4.] Kernel version (from /proc/version):
> 
> [gvtlinux@wulff linux-2.4.31]$ cat /proc/version
> Linux version 2.4.20-28.7 (bhcompile@porky.devel.redhat.com) (gcc 
> version 2.96 20000731 (Red Hat Linux 7.3 2.96-126)) #1 Thu Dec 18 
> 11:18:28 EST 2003    
>...
> I  expect you to tell me to upgrade everything.  Thanks for taking this 
> bug report.


No, there are usually two possible causes of this problem, both of them 
are not in the kernel:

If you try building the module again and the error does _not_ show up 
at _exactly_ the same place you have a hardware problem (e.g. bad RAM).

If the problem does reproducible show up at the same place, it's a bug 
in gcc. In this case, gcc has already told you where to report it (but I 
don't know whether RedHat 7.3 is still supported by RedHat).


> Thanks
> 
> George Van Tuyl

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

