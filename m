Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbQKLOV1>; Sun, 12 Nov 2000 09:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbQKLOVR>; Sun, 12 Nov 2000 09:21:17 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:53587
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130667AbQKLOVB>; Sun, 12 Nov 2000 09:21:01 -0500
Date: Sun, 12 Nov 2000 15:13:11 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Arjan Filius <iafilius@xs4all.nl>, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: 2.4.0-test11-pre3 doesn't compile (ax25 and md)
Message-ID: <20001112151310.H637@jaquet.dk>
In-Reply-To: <Pine.LNX.4.21.0011121308440.5594-100000@sjoerd.sjoerdnet> <3A0E8B99.2EA40AF0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A0E8B99.2EA40AF0@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Nov 12, 2000 at 07:22:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 07:22:49AM -0500, Jeff Garzik wrote:
> Arjan Filius wrote:
> > 
> > Hello,
> > 
> > I noticed also md.c doesn't compile (gcc version 2.95.2 )
> > Here is the (stripped) output from a make -i modules:
> > 
> > make -C md modules
> > make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c md.c
> > In file included from md.c:33:
> > /usr/src/linux/include/linux/sysctl.h:35: parse error before `size_t'
> 
> Either md.c or sysctl.h needs to include <linux/types.h>.
> 

I tried to include <linux/types.h> in md.c and had to include 
<linux/blkdev.h> also. Otherwise I got the following:

/home/rasmus/kernel/linux/include/linux/sysctl.h:598: syntax error before `long'/home/rasmus/kernel/linux/include/linux/sysctl.h:609: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:609: warning: its scope is only this definition or declaration,
/home/rasmus/kernel/linux/include/linux/sysctl.h:609: warning: which is probably not what you want.
/home/rasmus/kernel/linux/include/linux/sysctl.h:612: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:614: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:616: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:618: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:620: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:622: warning: `struct file' declared inside parameter list
/home/rasmus/kernel/linux/include/linux/sysctl.h:624: warning: `struct file' declared inside parameter list
drivers/md/md.c:89: warning: initialization from incompatible pointer type
drivers/md/md.c:91: warning: initialization from incompatible pointer type
drivers/md/md.c:3090: warning: `md_status_read_proc' defined but not used
make: *** [drivers/md/md.o] Error 1

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

The difference between theory and practice is that, in theory, there is 
no difference between theory and practice. -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
