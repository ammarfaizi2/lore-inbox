Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269067AbRHRWmO>; Sat, 18 Aug 2001 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269092AbRHRWmG>; Sat, 18 Aug 2001 18:42:06 -0400
Received: from [209.38.98.99] ([209.38.98.99]:34009 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S269067AbRHRWlu>;
	Sat, 18 Aug 2001 18:41:50 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_YACAQ07AV3Q2ETXDKMC3"
From: Fred Jackson <fred@arkansaswebs.com>
To: Tony Hoyle <tmh@nothing-on.tv>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx won't recompile.
Date: Sat, 18 Aug 2001 17:40:10 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01081812570001.09229@bits.linuxball> <001901c12810$97ef3a70$020a0a0a@totalmef> <3B7EB162.5070207@nothing-on.tv>
In-Reply-To: <3B7EB162.5070207@nothing-on.tv>
Cc: "Magnus Naeslund\(f\)" <mag@fbab.net>
MIME-Version: 1.0
Message-Id: <01081817401000.01028@bits.linuxball>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YACAQ07AV3Q2ETXDKMC3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

OK, tried it, twice, still doesn't wan't to compile the second time.
Followed your instructions, twice. Then I deleted the directory, 
untarred again, reconfigured the kernel from scratch, made it the 
first pass. then it would not recompile after I ran 'make xconfig', 
saved, and tried to recompile with 'make install'. then I ran 'make 
mrproper', 'make xconfig', 'make dep', make install ----- broke again 
with the following perplexing errors.

all I can tell for sure is that the compiler doewn't seem to have a 
definition for FASTCALL.

thank you for your input.

Fred

______________________________________________________________

[root@bits linux]# make install
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/b2/sw/linux-2.4.9/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=k6   -c -o init/main.o init/main.c
In file included from /b2/sw/linux-2.4.9/include/linux/fs.h:19,
                 from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/dcache.h: In function `dget':
/b2/sw/linux-2.4.9/include/linux/dcache.h:244: warning: implicit 
declaration of function `printk'
In file included from /b2/sw/linux-2.4.9/include/asm/semaphore.h:39,
                 from /b2/sw/linux-2.4.9/include/linux/fs.h:198,
                 from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/asm/system.h: At top level:
/b2/sw/linux-2.4.9/include/asm/system.h:12: parse error before `('
In file included from /b2/sw/linux-2.4.9/include/linux/rwsem.h:27,
                 from /b2/sw/linux-2.4.9/include/asm/semaphore.h:42,
                 from /b2/sw/linux-2.4.9/include/linux/fs.h:198,
                 from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/asm/rwsem.h:46: parse error before `('
/b2/sw/linux-2.4.9/include/asm/rwsem.h:47: parse error before `('
/b2/sw/linux-2.4.9/include/asm/rwsem.h:48: parse error before `('
In file included from 
/b2/sw/linux-2.4.9/include/linux/capability.h:17,
                 from /b2/sw/linux-2.4.9/include/linux/binfmts.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/sched.h:9,
                 from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/fs.h: In function `put_bh':
/b2/sw/linux-2.4.9/include/linux/fs.h:1082: warning: implicit 
declaration of function `barrier'
/b2/sw/linux-2.4.9/include/linux/fs.h: At top level:
/b2/sw/linux-2.4.9/include/linux/fs.h:1123: parse error before `('
/b2/sw/linux-2.4.9/include/linux/fs.h:1124: parse error before `('
/b2/sw/linux-2.4.9/include/linux/fs.h: In function 
`mark_buffer_dirty_inode':
/b2/sw/linux-2.4.9/include/linux/fs.h:1146: warning: implicit 
declaration of function `mark_buffer_dirty'
In file included from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/sched.h: At top level:
/b2/sw/linux-2.4.9/include/linux/sched.h:153: parse error before `('
In file included from /b2/sw/linux-2.4.9/include/linux/mm.h:4,
                 from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/sched.h:551: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:552: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:553: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:554: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:556: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:557: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:559: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:721: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h: In function `mmdrop':
/b2/sw/linux-2.4.9/include/linux/sched.h:725: warning: implicit 
declaration of function `__mmdrop' 
/b2/sw/linux-2.4.9/include/linux/sched.h: At top level:
/b2/sw/linux-2.4.9/include/linux/sched.h:757: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:758: parse error before `('
/b2/sw/linux-2.4.9/include/linux/sched.h:759: parse error before `('
In file included from /b2/sw/linux-2.4.9/include/linux/slab.h:14,
                 from /b2/sw/linux-2.4.9/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/b2/sw/linux-2.4.9/include/linux/mm.h:383: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:384: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h: In function `alloc_pages':
/b2/sw/linux-2.4.9/include/linux/mm.h:394: warning: implicit 
declaration of function 
`_alloc_pages'/b2/sw/linux-2.4.9/include/linux/mm.h:394: warning: 
return makes pointer from integer without a cast
/b2/sw/linux-2.4.9/include/linux/mm.h: At top level:
/b2/sw/linux-2.4.9/include/linux/mm.h:399: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:400: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:416: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:417: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:438: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h:439: parse error before `('
/b2/sw/linux-2.4.9/include/linux/mm.h: In function `pmd_alloc':
/b2/sw/linux-2.4.9/include/linux/mm.h:455: warning: implicit 
declaration of function `__pmd_alloc' 
/b2/sw/linux-2.4.9/include/linux/mm.h:455: warning: return makes 
pointer from integer without a cast
In file included from /b2/sw/linux-2.4.9/include/linux/highmem.h:5,
                 from /b2/sw/linux-2.4.9/include/linux/pagemap.h:16,
                 from /b2/sw/linux-2.4.9/include/linux/locks.h:8,
                 from 
/b2/sw/linux-2.4.9/include/linux/devfs_fs_kernel.h:6,
                 from init/main.c:16:
/b2/sw/linux-2.4.9/include/asm/pgalloc.h: In function `get_pgd_slow':
/b2/sw/linux-2.4.9/include/asm/pgalloc.h:53: warning: implicit 
declaration of function `__get_free_pages'
/b2/sw/linux-2.4.9/include/asm/pgalloc.h: In function `free_pgd_slow':
/b2/sw/linux-2.4.9/include/asm/pgalloc.h:93: warning: implicit 
declaration of function `free_pages'In file included from 
/b2/sw/linux-2.4.9/include/linux/irq.h:57,
                 from /b2/sw/linux-2.4.9/include/asm/hardirq.h:6,
                 from /b2/sw/linux-2.4.9/include/linux/interrupt.h:45,
                 from 
/b2/sw/linux-2.4.9/include/linux/netdevice.h:424,
                 from /b2/sw/linux-2.4.9/include/net/ip.h:29,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/asm/hw_irq.h: At top level:
/b2/sw/linux-2.4.9/include/asm/hw_irq.h:78: parse error before `('
In file included from 
/b2/sw/linux-2.4.9/include/linux/netdevice.h:424,
                 from /b2/sw/linux-2.4.9/include/net/ip.h:29,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/interrupt.h:77: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h:78: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h:154: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h: In function 
`tasklet_schedule':
/b2/sw/linux-2.4.9/include/linux/interrupt.h:159: warning: implicit 
declaration of function `__tasklet_schedule'
/b2/sw/linux-2.4.9/include/linux/interrupt.h: At top level:
/b2/sw/linux-2.4.9/include/linux/interrupt.h:162: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/interrupt.h: In function 
`tasklet_hi_schedule':
/b2/sw/linux-2.4.9/include/linux/interrupt.h:167: warning: implicit 
declaration of function `__tasklet_hi_schedule'
In file included from /b2/sw/linux-2.4.9/include/net/ip.h:29,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/netdevice.h: In function 
`__netif_schedule':
/b2/sw/linux-2.4.9/include/linux/netdevice.h:489: warning: implicit 
declaration of function `cpu_raise_softirq'
In file included from /b2/sw/linux-2.4.9/include/net/ip.h:39,
                 from /b2/sw/linux-2.4.9/include/net/checksum.h:31,
                 from /b2/sw/linux-2.4.9/include/linux/raid/md.h:34,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/net/sock.h: In function `sock_rcvlowat':
/b2/sw/linux-2.4.9/include/net/sock.h:1248: warning: implicit 
declaration of function `min'
/b2/sw/linux-2.4.9/include/net/sock.h:1248: parse error before `int'
/b2/sw/linux-2.4.9/include/net/sock.h:1249: warning: control reaches 
end of non-void function
/b2/sw/linux-2.4.9/include/net/sock.h: In function `sock_intr_errno':
/b2/sw/linux-2.4.9/include/net/sock.h:1256: `LONG_MAX' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/net/sock.h:1256: (Each undeclared 
identifier is reported only once
/b2/sw/linux-2.4.9/include/net/sock.h:1256: for each function it 
appears in.)
/b2/sw/linux-2.4.9/include/net/sock.h:1257: warning: control reaches 
end of non-void function
In file included from /b2/sw/linux-2.4.9/include/linux/raid/md.h:39,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/completion.h: At top level:
/b2/sw/linux-2.4.9/include/linux/completion.h:30: parse error before 
`('
/b2/sw/linux-2.4.9/include/linux/completion.h:31: parse error before 
`('
In file included from /b2/sw/linux-2.4.9/include/linux/raid/md.h:51,
                 from init/main.c:24:
/b2/sw/linux-2.4.9/include/linux/raid/md_k.h: In function 
`pers_to_level':
/b2/sw/linux-2.4.9/include/linux/raid/md_k.h:38: warning: implicit 
declaration of function `panic'
In file included from init/main.c:33:
/b2/sw/linux-2.4.9/include/asm/bugs.h: In function `check_fpu':
/b2/sw/linux-2.4.9/include/asm/bugs.h:71: `KERN_EMERG' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/asm/bugs.h:71: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h:72: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h:87: `KERN_INFO' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/asm/bugs.h:87: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h:92: parse error before string 
constant
/b2/sw/linux-2.4.9/include/asm/bugs.h: In function `check_hlt':
/b2/sw/linux-2.4.9/include/asm/bugs.h:115: `KERN_INFO' undeclared 
(first use in this function)
/b2/sw/linux-2.4.9/include/asm/bugs.h:115: parse error before string 
constant
init/main.c: In function `profile_setup':
init/main.c:138: warning: implicit declaration of function 
`get_option'
init/main.c: In function `name_to_kdev_t':
init/main.c:285: warning: implicit declaration of function 
`simple_strtoul'
init/main.c: In function `debug_kernel':
init/main.c:393: `console_loglevel' undeclared (first use in this 
function)
init/main.c: In function `quiet_kernel':
init/main.c:401: `console_loglevel' undeclared (first use in this 
function)
make: *** [init/main.o] Error 1
[root@bits linux]#



Fred


_________________________________ 
On Saturday 18 August 2001 01:18 pm, Tony Hoyle wrote:
> Magnus Naeslund(f) wrote:
> 
> > Isn't it more safe to do it like this:
> > 
> > make mrproper
> > cp ../linux-2.4.8/.config .
> > make oldconfig
> > make xconfig
> > make bzImage && make modules && make modules_install && make 
install
> > 
> > ?
> > I thought this was the proper way to do it, no?
> > 
> You don't need to make bzimage first, and you missed the dep/clean 
steps 
> (theoretically not needed any more but I've had some really strange 
> compiler errors by missing them out).
> 
> cp ../linux-2.4.8/.config .
> make oldconfig
> make xconfig
> make dep clean install modules modules_install
> 
> Tony
> 
> -

--------------Boundary-00=_YACAQ07AV3Q2ETXDKMC3
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="system.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="system.h"

I2lmbmRlZiBfX0FTTV9TWVNURU1fSAojZGVmaW5lIF9fQVNNX1NZU1RFTV9ICgojaW5jbHVkZSA8
bGludXgvY29uZmlnLmg+CiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KI2luY2x1ZGUgPGFzbS9z
ZWdtZW50Lmg+CiNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4gLyogZm9yIExPQ0tfUFJFRklYICov
CgojaWZkZWYgX19LRVJORUxfXwoKc3RydWN0IHRhc2tfc3RydWN0OwkvKiBvbmUgb2YgdGhlIHN0
cmFuZ2VyIGFzcGVjdHMgb2YgQyBmb3J3YXJkIGRlY2xhcmF0aW9ucy4uICovCmV4dGVybiB2b2lk
IEZBU1RDQUxMKF9fc3dpdGNoX3RvKHN0cnVjdCB0YXNrX3N0cnVjdCAqcHJldiwgc3RydWN0IHRh
c2tfc3RydWN0ICpuZXh0KSk7CgojZGVmaW5lIHByZXBhcmVfdG9fc3dpdGNoKCkJZG8geyB9IHdo
aWxlKDApCiNkZWZpbmUgc3dpdGNoX3RvKHByZXYsbmV4dCxsYXN0KSBkbyB7CQkJCQlcCglhc20g
dm9sYXRpbGUoInB1c2hsICUlZXNpXG5cdCIJCQkJCVwKCQkgICAgICJwdXNobCAlJWVkaVxuXHQi
CQkJCQlcCgkJICAgICAicHVzaGwgJSVlYnBcblx0IgkJCQkJXAoJCSAgICAgIm1vdmwgJSVlc3As
JTBcblx0IgkvKiBzYXZlIEVTUCAqLwkJXAoJCSAgICAgIm1vdmwgJTMsJSVlc3Bcblx0IgkvKiBy
ZXN0b3JlIEVTUCAqLwlcCgkJICAgICAibW92bCAkMWYsJTFcblx0IgkJLyogc2F2ZSBFSVAgKi8J
CVwKCQkgICAgICJwdXNobCAlNFxuXHQiCQkvKiByZXN0b3JlIEVJUCAqLwlcCgkJICAgICAiam1w
IF9fc3dpdGNoX3RvXG4iCQkJCVwKCQkgICAgICIxOlx0IgkJCQkJCVwKCQkgICAgICJwb3BsICUl
ZWJwXG5cdCIJCQkJCVwKCQkgICAgICJwb3BsICUlZWRpXG5cdCIJCQkJCVwKCQkgICAgICJwb3Bs
ICUlZXNpXG5cdCIJCQkJCVwKCQkgICAgIDoiPW0iIChwcmV2LT50aHJlYWQuZXNwKSwiPW0iIChw
cmV2LT50aHJlYWQuZWlwKSwJXAoJCSAgICAgICI9YiIgKGxhc3QpCQkJCQlcCgkJICAgICA6Im0i
IChuZXh0LT50aHJlYWQuZXNwKSwibSIgKG5leHQtPnRocmVhZC5laXApLAlcCgkJICAgICAgImEi
IChwcmV2KSwgImQiIChuZXh0KSwJCQkJXAoJCSAgICAgICJiIiAocHJldikpOwkJCQkJXAp9IHdo
aWxlICgwKQoKI2RlZmluZSBfc2V0X2Jhc2UoYWRkcixiYXNlKSBkbyB7IHVuc2lnbmVkIGxvbmcg
X19wcjsgXApfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIm1vdncgJSVkeCwlMVxuXHQiIFwKCSJyb3Js
ICQxNiwlJWVkeFxuXHQiIFwKCSJtb3ZiICUlZGwsJTJcblx0IiBcCgkibW92YiAlJWRoLCUzIiBc
Cgk6Ij0mZCIgKF9fcHIpIFwKCToibSIgKCooKGFkZHIpKzIpKSwgXAoJICJtIiAoKigoYWRkcikr
NCkpLCBcCgkgIm0iICgqKChhZGRyKSs3KSksIFwKICAgICAgICAgIjAiIChiYXNlKSBcCiAgICAg
ICAgKTsgfSB3aGlsZSgwKQoKI2RlZmluZSBfc2V0X2xpbWl0KGFkZHIsbGltaXQpIGRvIHsgdW5z
aWduZWQgbG9uZyBfX2xyOyBcCl9fYXNtX18gX192b2xhdGlsZV9fICgibW92dyAlJWR4LCUxXG5c
dCIgXAoJInJvcmwgJDE2LCUlZWR4XG5cdCIgXAoJIm1vdmIgJTIsJSVkaFxuXHQiIFwKCSJhbmRi
ICQweGYwLCUlZGhcblx0IiBcCgkib3JiICUlZGgsJSVkbFxuXHQiIFwKCSJtb3ZiICUlZGwsJTIi
IFwKCToiPSZkIiAoX19scikgXAoJOiJtIiAoKihhZGRyKSksIFwKCSAibSIgKCooKGFkZHIpKzYp
KSwgXAoJICIwIiAobGltaXQpIFwKICAgICAgICApOyB9IHdoaWxlKDApCgojZGVmaW5lIHNldF9i
YXNlKGxkdCxiYXNlKSBfc2V0X2Jhc2UoICgoY2hhciAqKSYobGR0KSkgLCAoYmFzZSkgKQojZGVm
aW5lIHNldF9saW1pdChsZHQsbGltaXQpIF9zZXRfbGltaXQoICgoY2hhciAqKSYobGR0KSkgLCAo
KGxpbWl0KS0xKT4+MTIgKQoKc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIF9nZXRfYmFzZShj
aGFyICogYWRkcikKewoJdW5zaWduZWQgbG9uZyBfX2Jhc2U7CglfX2FzbV9fKCJtb3ZiICUzLCUl
ZGhcblx0IgoJCSJtb3ZiICUyLCUlZGxcblx0IgoJCSJzaGxsICQxNiwlJWVkeFxuXHQiCgkJIm1v
dncgJTEsJSVkeCIKCQk6Ij0mZCIgKF9fYmFzZSkKCQk6Im0iICgqKChhZGRyKSsyKSksCgkJICJt
IiAoKigoYWRkcikrNCkpLAoJCSAibSIgKCooKGFkZHIpKzcpKSk7CglyZXR1cm4gX19iYXNlOwp9
CgojZGVmaW5lIGdldF9iYXNlKGxkdCkgX2dldF9iYXNlKCAoKGNoYXIgKikmKGxkdCkpICkKCi8q
CiAqIExvYWQgYSBzZWdtZW50LiBGYWxsIGJhY2sgb24gbG9hZGluZyB0aGUgemVybwogKiBzZWdt
ZW50IGlmIHNvbWV0aGluZyBnb2VzIHdyb25nLi4KICovCiNkZWZpbmUgbG9hZHNlZ21lbnQoc2Vn
LHZhbHVlKQkJCVwKCWFzbSB2b2xhdGlsZSgiXG4iCQkJXAoJCSIxOlx0IgkJCQlcCgkJIm1vdmwg
JTAsJSUiICNzZWcgIlxuIgkJXAoJCSIyOlxuIgkJCQlcCgkJIi5zZWN0aW9uIC5maXh1cCxcImF4
XCJcbiIJXAoJCSIzOlx0IgkJCQlcCgkJInB1c2hsICQwXG5cdCIJCQlcCgkJInBvcGwgJSUiICNz
ZWcgIlxuXHQiCQlcCgkJImptcCAyYlxuIgkJCVwKCQkiLnByZXZpb3VzXG4iCQkJXAoJCSIuc2Vj
dGlvbiBfX2V4X3RhYmxlLFwiYVwiXG5cdCIJXAoJCSIuYWxpZ24gNFxuXHQiCQkJXAoJCSIubG9u
ZyAxYiwzYlxuIgkJCVwKCQkiLnByZXZpb3VzIgkJCVwKCQk6IDoibSIgKCoodW5zaWduZWQgaW50
ICopJih2YWx1ZSkpKQoKLyoKICogQ2xlYXIgYW5kIHNldCAnVFMnIGJpdCByZXNwZWN0aXZlbHkK
ICovCiNkZWZpbmUgY2x0cygpIF9fYXNtX18gX192b2xhdGlsZV9fICgiY2x0cyIpCiNkZWZpbmUg
cmVhZF9jcjAoKSAoeyBcCgl1bnNpZ25lZCBpbnQgX19kdW1teTsgXAoJX19hc21fXyggXAoJCSJt
b3ZsICUlY3IwLCUwXG5cdCIgXAoJCToiPXIiIChfX2R1bW15KSk7IFwKCV9fZHVtbXk7IFwKfSkK
I2RlZmluZSB3cml0ZV9jcjAoeCkgXAoJX19hc21fXygibW92bCAlMCwlJWNyMCI6IDoiciIgKHgp
KTsKI2RlZmluZSBzdHRzKCkgd3JpdGVfY3IwKDggfCByZWFkX2NyMCgpKQoKI2VuZGlmCS8qIF9f
S0VSTkVMX18gKi8KCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBnZXRfbGltaXQodW5zaWdu
ZWQgbG9uZyBzZWdtZW50KQp7Cgl1bnNpZ25lZCBsb25nIF9fbGltaXQ7CglfX2FzbV9fKCJsc2xs
ICUxLCUwIgoJCToiPXIiIChfX2xpbWl0KToiciIgKHNlZ21lbnQpKTsKCXJldHVybiBfX2xpbWl0
KzE7Cn0KCiNkZWZpbmUgbm9wKCkgX19hc21fXyBfX3ZvbGF0aWxlX18gKCJub3AiKQoKI2RlZmlu
ZSB4Y2hnKHB0cix2KSAoKF9fdHlwZW9mX18oKihwdHIpKSlfX3hjaGcoKHVuc2lnbmVkIGxvbmcp
KHYpLChwdHIpLHNpemVvZigqKHB0cikpKSkKCiNkZWZpbmUgdGFzKHB0cikgKHhjaGcoKHB0ciks
MSkpCgpzdHJ1Y3QgX194Y2hnX2R1bW15IHsgdW5zaWduZWQgbG9uZyBhWzEwMF07IH07CiNkZWZp
bmUgX194Zyh4KSAoKHN0cnVjdCBfX3hjaGdfZHVtbXkgKikoeCkpCgoKLyoKICogVGhlIHNlbWFu
dGljcyBvZiBYQ0hHQ01QOEIgYXJlIGEgYml0IHN0cmFuZ2UsIHRoaXMgaXMgd2h5CiAqIHRoZXJl
IGlzIGEgbG9vcCBhbmQgdGhlIGxvYWRpbmcgb2YgJSVlYXggYW5kICUlZWR4IGhhcyB0bwogKiBi
ZSBpbnNpZGUuIFRoaXMgaW5saW5lcyB3ZWxsIGluIG1vc3QgY2FzZXMsIHRoZSBjYWNoZWQKICog
Y29zdCBpcyBhcm91bmQgfjM4IGN5Y2xlcy4gKGluIHRoZSBmdXR1cmUgd2UgbWlnaHQgd2FudAog
KiB0byBkbyBhbiBTSU1ELzNETk9XIS9NTVgvRlBVIDY0LWJpdCBzdG9yZSBoZXJlLCBidXQgdGhh
dAogKiBtaWdodCBoYXZlIGFuIGltcGxpY2l0IEZQVS1zYXZlIGFzIGEgY29zdCwgc28gaXQncyBu
b3QKICogY2xlYXIgd2hpY2ggcGF0aCB0byBnby4pCiAqLwpzdGF0aWMgaW5saW5lIHZvaWQgX19z
ZXRfNjRiaXQgKHVuc2lnbmVkIGxvbmcgbG9uZyAqIHB0ciwKCQl1bnNpZ25lZCBpbnQgbG93LCB1
bnNpZ25lZCBpbnQgaGlnaCkKewoJX19hc21fXyBfX3ZvbGF0aWxlX18gKAoJCSJcbjE6XHQiCgkJ
Im1vdmwgKCUwKSwgJSVlYXhcblx0IgoJCSJtb3ZsIDQoJTApLCAlJWVkeFxuXHQiCgkJImNtcHhj
aGc4YiAoJTApXG5cdCIKCQkiam56IDFiIgoJCTogLyogbm8gb3V0cHV0cyAqLwoJCToJIkQiKHB0
ciksCgkJCSJiIihsb3cpLAoJCQkiYyIoaGlnaCkKCQk6CSJheCIsImR4IiwibWVtb3J5Iik7Cn0K
CnN0YXRpYyBpbmxpbmUgdm9pZCBfX3NldF82NGJpdF9jb25zdGFudCAodW5zaWduZWQgbG9uZyBs
b25nICpwdHIsCgkJCQkJCSB1bnNpZ25lZCBsb25nIGxvbmcgdmFsdWUpCnsKCV9fc2V0XzY0Yml0
KHB0ciwodW5zaWduZWQgaW50KSh2YWx1ZSksICh1bnNpZ25lZCBpbnQpKCh2YWx1ZSk+PjMyVUxM
KSk7Cn0KI2RlZmluZSBsbF9sb3coeCkJKigoKHVuc2lnbmVkIGludCopJih4KSkrMCkKI2RlZmlu
ZSBsbF9oaWdoKHgpCSooKCh1bnNpZ25lZCBpbnQqKSYoeCkpKzEpCgpzdGF0aWMgaW5saW5lIHZv
aWQgX19zZXRfNjRiaXRfdmFyICh1bnNpZ25lZCBsb25nIGxvbmcgKnB0ciwKCQkJIHVuc2lnbmVk
IGxvbmcgbG9uZyB2YWx1ZSkKewoJX19zZXRfNjRiaXQocHRyLGxsX2xvdyh2YWx1ZSksIGxsX2hp
Z2godmFsdWUpKTsKfQoKI2RlZmluZSBzZXRfNjRiaXQocHRyLHZhbHVlKSBcCihfX2J1aWx0aW5f
Y29uc3RhbnRfcCh2YWx1ZSkgPyBcCiBfX3NldF82NGJpdF9jb25zdGFudChwdHIsIHZhbHVlKSA6
IFwKIF9fc2V0XzY0Yml0X3ZhcihwdHIsIHZhbHVlKSApCgojZGVmaW5lIF9zZXRfNjRiaXQocHRy
LHZhbHVlKSBcCihfX2J1aWx0aW5fY29uc3RhbnRfcCh2YWx1ZSkgPyBcCiBfX3NldF82NGJpdChw
dHIsICh1bnNpZ25lZCBpbnQpKHZhbHVlKSwgKHVuc2lnbmVkIGludCkoKHZhbHVlKT4+MzJVTEwp
ICkgOiBcCiBfX3NldF82NGJpdChwdHIsIGxsX2xvdyh2YWx1ZSksIGxsX2hpZ2godmFsdWUpKSAp
CgovKgogKiBOb3RlOiBubyAibG9jayIgcHJlZml4IGV2ZW4gb24gU01QOiB4Y2hnIGFsd2F5cyBp
bXBsaWVzIGxvY2sgYW55d2F5CiAqIE5vdGUgMjogeGNoZyBoYXMgc2lkZSBlZmZlY3QsIHNvIHRo
YXQgYXR0cmlidXRlIHZvbGF0aWxlIGlzIG5lY2Vzc2FyeSwKICoJICBidXQgZ2VuZXJhbGx5IHRo
ZSBwcmltaXRpdmUgaXMgaW52YWxpZCwgKnB0ciBpcyBvdXRwdXQgYXJndW1lbnQuIC0tQU5LCiAq
LwpzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX194Y2hnKHVuc2lnbmVkIGxvbmcgeCwgdm9s
YXRpbGUgdm9pZCAqIHB0ciwgaW50IHNpemUpCnsKCXN3aXRjaCAoc2l6ZSkgewoJCWNhc2UgMToK
CQkJX19hc21fXyBfX3ZvbGF0aWxlX18oInhjaGdiICViMCwlMSIKCQkJCToiPXEiICh4KQoJCQkJ
OiJtIiAoKl9feGcocHRyKSksICIwIiAoeCkKCQkJCToibWVtb3J5Iik7CgkJCWJyZWFrOwoJCWNh
c2UgMjoKCQkJX19hc21fXyBfX3ZvbGF0aWxlX18oInhjaGd3ICV3MCwlMSIKCQkJCToiPXIiICh4
KQoJCQkJOiJtIiAoKl9feGcocHRyKSksICIwIiAoeCkKCQkJCToibWVtb3J5Iik7CgkJCWJyZWFr
OwoJCWNhc2UgNDoKCQkJX19hc21fXyBfX3ZvbGF0aWxlX18oInhjaGdsICUwLCUxIgoJCQkJOiI9
ciIgKHgpCgkJCQk6Im0iICgqX194ZyhwdHIpKSwgIjAiICh4KQoJCQkJOiJtZW1vcnkiKTsKCQkJ
YnJlYWs7Cgl9CglyZXR1cm4geDsKfQoKLyoKICogQXRvbWljIGNvbXBhcmUgYW5kIGV4Y2hhbmdl
LiAgQ29tcGFyZSBPTEQgd2l0aCBNRU0sIGlmIGlkZW50aWNhbCwKICogc3RvcmUgTkVXIGluIE1F
TS4gIFJldHVybiB0aGUgaW5pdGlhbCB2YWx1ZSBpbiBNRU0uICBTdWNjZXNzIGlzCiAqIGluZGlj
YXRlZCBieSBjb21wYXJpbmcgUkVUVVJOIHdpdGggT0xELgogKi8KCiNpZmRlZiBDT05GSUdfWDg2
X0NNUFhDSEcKI2RlZmluZSBfX0hBVkVfQVJDSF9DTVBYQ0hHIDEKCnN0YXRpYyBpbmxpbmUgdW5z
aWduZWQgbG9uZyBfX2NtcHhjaGcodm9sYXRpbGUgdm9pZCAqcHRyLCB1bnNpZ25lZCBsb25nIG9s
ZCwKCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgbmV3LCBpbnQgc2l6ZSkKewoJdW5zaWduZWQgbG9u
ZyBwcmV2OwoJc3dpdGNoIChzaXplKSB7CgljYXNlIDE6CgkJX19hc21fXyBfX3ZvbGF0aWxlX18o
TE9DS19QUkVGSVggImNtcHhjaGdiICViMSwlMiIKCQkJCSAgICAgOiAiPWEiKHByZXYpCgkJCQkg
ICAgIDogInEiKG5ldyksICJtIigqX194ZyhwdHIpKSwgIjAiKG9sZCkKCQkJCSAgICAgOiAibWVt
b3J5Iik7CgkJcmV0dXJuIHByZXY7CgljYXNlIDI6CgkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9D
S19QUkVGSVggImNtcHhjaGd3ICV3MSwlMiIKCQkJCSAgICAgOiAiPWEiKHByZXYpCgkJCQkgICAg
IDogInEiKG5ldyksICJtIigqX194ZyhwdHIpKSwgIjAiKG9sZCkKCQkJCSAgICAgOiAibWVtb3J5
Iik7CgkJcmV0dXJuIHByZXY7CgljYXNlIDQ6CgkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19Q
UkVGSVggImNtcHhjaGdsICUxLCUyIgoJCQkJICAgICA6ICI9YSIocHJldikKCQkJCSAgICAgOiAi
cSIobmV3KSwgIm0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQoJCQkJICAgICA6ICJtZW1vcnkiKTsK
CQlyZXR1cm4gcHJldjsKCX0KCXJldHVybiBvbGQ7Cn0KCiNkZWZpbmUgY21weGNoZyhwdHIsbyxu
KVwKCSgoX190eXBlb2ZfXygqKHB0cikpKV9fY21weGNoZygocHRyKSwodW5zaWduZWQgbG9uZyko
byksXAoJCQkJCSh1bnNpZ25lZCBsb25nKShuKSxzaXplb2YoKihwdHIpKSkpCiAgICAKI2Vsc2UK
LyogQ29tcGlsaW5nIGZvciBhIDM4NiBwcm9wZXIuCUlzIGl0IHdvcnRoIGltcGxlbWVudGluZyB2
aWEgY2xpL3N0aT8gICovCiNlbmRpZgoKLyoKICogRm9yY2Ugc3RyaWN0IENQVSBvcmRlcmluZy4K
ICogQW5kIHllcywgdGhpcyBpcyByZXF1aXJlZCBvbiBVUCB0b28gd2hlbiB3ZSdyZSB0YWxraW5n
CiAqIHRvIGRldmljZXMuCiAqCiAqIEZvciBub3csICJ3bWIoKSIgZG9lc24ndCBhY3R1YWxseSBk
byBhbnl0aGluZywgYXMgYWxsCiAqIEludGVsIENQVSdzIGZvbGxvdyB3aGF0IEludGVsIGNhbGxz
IGEgKlByb2Nlc3NvciBPcmRlciosCiAqIGluIHdoaWNoIGFsbCB3cml0ZXMgYXJlIHNlZW4gaW4g
dGhlIHByb2dyYW0gb3JkZXIgZXZlbgogKiBvdXRzaWRlIHRoZSBDUFUuCiAqCiAqIEkgZXhwZWN0
IGZ1dHVyZSBJbnRlbCBDUFUncyB0byBoYXZlIGEgd2Vha2VyIG9yZGVyaW5nLAogKiBidXQgSSdk
IGFsc28gZXhwZWN0IHRoZW0gdG8gZmluYWxseSBnZXQgdGhlaXIgYWN0IHRvZ2V0aGVyCiAqIGFu
ZCBhZGQgc29tZSByZWFsIG1lbW9yeSBiYXJyaWVycyBpZiBzby4KICovCiNkZWZpbmUgbWIoKSAJ
X19hc21fXyBfX3ZvbGF0aWxlX18gKCJsb2NrOyBhZGRsICQwLDAoJSVlc3ApIjogOiA6Im1lbW9y
eSIpCiNkZWZpbmUgcm1iKCkJbWIoKQojZGVmaW5lIHdtYigpCV9fYXNtX18gX192b2xhdGlsZV9f
ICgiIjogOiA6Im1lbW9yeSIpCgojaWZkZWYgQ09ORklHX1NNUAojZGVmaW5lIHNtcF9tYigpCW1i
KCkKI2RlZmluZSBzbXBfcm1iKCkJcm1iKCkKI2RlZmluZSBzbXBfd21iKCkJd21iKCkKI2Vsc2UK
I2RlZmluZSBzbXBfbWIoKQliYXJyaWVyKCkKI2RlZmluZSBzbXBfcm1iKCkJYmFycmllcigpCiNk
ZWZpbmUgc21wX3dtYigpCWJhcnJpZXIoKQojZW5kaWYKCiNkZWZpbmUgc2V0X21iKHZhciwgdmFs
dWUpIGRvIHsgeGNoZygmdmFyLCB2YWx1ZSk7IH0gd2hpbGUgKDApCiNkZWZpbmUgc2V0X3dtYih2
YXIsIHZhbHVlKSBkbyB7IHZhciA9IHZhbHVlOyB3bWIoKTsgfSB3aGlsZSAoMCkKCi8qIGludGVy
cnVwdCBjb250cm9sLi4gKi8KI2RlZmluZSBfX3NhdmVfZmxhZ3MoeCkJCV9fYXNtX18gX192b2xh
dGlsZV9fKCJwdXNoZmwgOyBwb3BsICUwIjoiPWciICh4KTogLyogbm8gaW5wdXQgKi8pCiNkZWZp
bmUgX19yZXN0b3JlX2ZsYWdzKHgpIAlfX2FzbV9fIF9fdm9sYXRpbGVfXygicHVzaGwgJTAgOyBw
b3BmbCI6IC8qIG5vIG91dHB1dCAqLyA6ImciICh4KToibWVtb3J5IiwgImNjIikKI2RlZmluZSBf
X2NsaSgpIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oImNsaSI6IDogOiJtZW1vcnkiKQojZGVmaW5l
IF9fc3RpKCkJCQlfX2FzbV9fIF9fdm9sYXRpbGVfXygic3RpIjogOiA6Im1lbW9yeSIpCi8qIHVz
ZWQgaW4gdGhlIGlkbGUgbG9vcDsgc3RpIHRha2VzIG9uZSBpbnN0cnVjdGlvbiBjeWNsZSB0byBj
b21wbGV0ZSAqLwojZGVmaW5lIHNhZmVfaGFsdCgpCQlfX2FzbV9fIF9fdm9sYXRpbGVfXygic3Rp
OyBobHQiOiA6IDoibWVtb3J5IikKCi8qIEZvciBzcGlubG9ja3MgZXRjICovCiNkZWZpbmUgbG9j
YWxfaXJxX3NhdmUoeCkJX19hc21fXyBfX3ZvbGF0aWxlX18oInB1c2hmbCA7IHBvcGwgJTAgOyBj
bGkiOiI9ZyIgKHgpOiAvKiBubyBpbnB1dCAqLyA6Im1lbW9yeSIpCiNkZWZpbmUgbG9jYWxfaXJx
X3Jlc3RvcmUoeCkJX19yZXN0b3JlX2ZsYWdzKHgpCiNkZWZpbmUgbG9jYWxfaXJxX2Rpc2FibGUo
KQlfX2NsaSgpCiNkZWZpbmUgbG9jYWxfaXJxX2VuYWJsZSgpCV9fc3RpKCkKCiNpZmRlZiBDT05G
SUdfU01QCgpleHRlcm4gdm9pZCBfX2dsb2JhbF9jbGkodm9pZCk7CmV4dGVybiB2b2lkIF9fZ2xv
YmFsX3N0aSh2b2lkKTsKZXh0ZXJuIHVuc2lnbmVkIGxvbmcgX19nbG9iYWxfc2F2ZV9mbGFncyh2
b2lkKTsKZXh0ZXJuIHZvaWQgX19nbG9iYWxfcmVzdG9yZV9mbGFncyh1bnNpZ25lZCBsb25nKTsK
I2RlZmluZSBjbGkoKSBfX2dsb2JhbF9jbGkoKQojZGVmaW5lIHN0aSgpIF9fZ2xvYmFsX3N0aSgp
CiNkZWZpbmUgc2F2ZV9mbGFncyh4KSAoKHgpPV9fZ2xvYmFsX3NhdmVfZmxhZ3MoKSkKI2RlZmlu
ZSByZXN0b3JlX2ZsYWdzKHgpIF9fZ2xvYmFsX3Jlc3RvcmVfZmxhZ3MoeCkKCiNlbHNlCgojZGVm
aW5lIGNsaSgpIF9fY2xpKCkKI2RlZmluZSBzdGkoKSBfX3N0aSgpCiNkZWZpbmUgc2F2ZV9mbGFn
cyh4KSBfX3NhdmVfZmxhZ3MoeCkKI2RlZmluZSByZXN0b3JlX2ZsYWdzKHgpIF9fcmVzdG9yZV9m
bGFncyh4KQoKI2VuZGlmCgovKgogKiBkaXNhYmxlIGhsdCBkdXJpbmcgY2VydGFpbiBjcml0aWNh
bCBpL28gb3BlcmF0aW9ucwogKi8KI2RlZmluZSBIQVZFX0RJU0FCTEVfSExUCnZvaWQgZGlzYWJs
ZV9obHQodm9pZCk7CnZvaWQgZW5hYmxlX2hsdCh2b2lkKTsKCiNlbmRpZgo=

--------------Boundary-00=_YACAQ07AV3Q2ETXDKMC3
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="rwsem.h"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rwsem.h"

LyogcndzZW0uaDogUi9XIHNlbWFwaG9yZXMgaW1wbGVtZW50ZWQgdXNpbmcgWEFERC9DTVBYQ0hH
IGZvciBpNDg2KwogKgogKiBXcml0dGVuIGJ5IERhdmlkIEhvd2VsbHMgKGRob3dlbGxzQHJlZGhh
dC5jb20pLgogKgogKiBEZXJpdmVkIGZyb20gYXNtLWkzODYvc2VtYXBob3JlLmgKICoKICoKICog
VGhlIE1TVyBvZiB0aGUgY291bnQgaXMgdGhlIG5lZ2F0ZWQgbnVtYmVyIG9mIGFjdGl2ZSB3cml0
ZXJzIGFuZCB3YWl0aW5nCiAqIGxvY2tlcnMsIGFuZCB0aGUgTFNXIGlzIHRoZSB0b3RhbCBudW1i
ZXIgb2YgYWN0aXZlIGxvY2tzCiAqCiAqIFRoZSBsb2NrIGNvdW50IGlzIGluaXRpYWxpemVkIHRv
IDAgKG5vIGFjdGl2ZSBhbmQgbm8gd2FpdGluZyBsb2NrZXJzKS4KICoKICogV2hlbiBhIHdyaXRl
ciBzdWJ0cmFjdHMgV1JJVEVfQklBUywgaXQnbGwgZ2V0IDB4ZmZmZjAwMDEgZm9yIHRoZSBjYXNl
IG9mIGFuCiAqIHVuY29udGVuZGVkIGxvY2suIFRoaXMgY2FuIGJlIGRldGVybWluZWQgYmVjYXVz
ZSBYQUREIHJldHVybnMgdGhlIG9sZCB2YWx1ZS4KICogUmVhZGVycyBpbmNyZW1lbnQgYnkgMSBh
bmQgc2VlIGEgcG9zaXRpdmUgdmFsdWUgd2hlbiB1bmNvbnRlbmRlZCwgbmVnYXRpdmUKICogaWYg
dGhlcmUgYXJlIHdyaXRlcnMgKGFuZCBtYXliZSkgcmVhZGVycyB3YWl0aW5nIChpbiB3aGljaCBj
YXNlIGl0IGdvZXMgdG8KICogc2xlZXApLgogKgogKiBUaGUgdmFsdWUgb2YgV0FJVElOR19CSUFT
IHN1cHBvcnRzIHVwIHRvIDMyNzY2IHdhaXRpbmcgcHJvY2Vzc2VzLiBUaGlzIGNhbgogKiBiZSBl
eHRlbmRlZCB0byA2NTUzNCBieSBtYW51YWxseSBjaGVja2luZyB0aGUgd2hvbGUgTVNXIHJhdGhl
ciB0aGFuIHJlbHlpbmcKICogb24gdGhlIFMgZmxhZy4KICoKICogVGhlIHZhbHVlIG9mIEFDVElW
RV9CSUFTIHN1cHBvcnRzIHVwIHRvIDY1NTM1IGFjdGl2ZSBwcm9jZXNzZXMuCiAqCiAqIFRoaXMg
c2hvdWxkIGJlIHRvdGFsbHkgZmFpciAtIGlmIGFueXRoaW5nIGlzIHdhaXRpbmcsIGEgcHJvY2Vz
cyB0aGF0IHdhbnRzIGEKICogbG9jayB3aWxsIGdvIHRvIHRoZSBiYWNrIG9mIHRoZSBxdWV1ZS4g
V2hlbiB0aGUgY3VycmVudGx5IGFjdGl2ZSBsb2NrIGlzCiAqIHJlbGVhc2VkLCBpZiB0aGVyZSdz
IGEgd3JpdGVyIGF0IHRoZSBmcm9udCBvZiB0aGUgcXVldWUsIHRoZW4gdGhhdCBhbmQgb25seQog
KiB0aGF0IHdpbGwgYmUgd29rZW4gdXA7IGlmIHRoZXJlJ3MgYSBidW5jaCBvZiBjb25zZXF1dGl2
ZSByZWFkZXJzIGF0IHRoZQogKiBmcm9udCwgdGhlbiB0aGV5J2xsIGFsbCBiZSB3b2tlbiB1cCwg
YnV0IG5vIG90aGVyIHJlYWRlcnMgd2lsbCBiZS4KICovCgojaWZuZGVmIF9JMzg2X1JXU0VNX0gK
I2RlZmluZSBfSTM4Nl9SV1NFTV9ICgojaWZuZGVmIF9MSU5VWF9SV1NFTV9ICiNlcnJvciBwbGVh
c2UgZG9udCBpbmNsdWRlIGFzbS9yd3NlbS5oIGRpcmVjdGx5LCB1c2UgbGludXgvcndzZW0uaCBp
bnN0ZWFkCiNlbmRpZgoKI2lmZGVmIF9fS0VSTkVMX18KCiNpbmNsdWRlIDxsaW51eC9saXN0Lmg+
CiNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgoKc3RydWN0IHJ3c2VtX3dhaXRlcjsKCmV4dGVy
biBzdHJ1Y3Qgcndfc2VtYXBob3JlICpGQVNUQ0FMTChyd3NlbV9kb3duX3JlYWRfZmFpbGVkKHN0
cnVjdCByd19zZW1hcGhvcmUgKnNlbSkpOwpleHRlcm4gc3RydWN0IHJ3X3NlbWFwaG9yZSAqRkFT
VENBTEwocndzZW1fZG93bl93cml0ZV9mYWlsZWQoc3RydWN0IHJ3X3NlbWFwaG9yZSAqc2VtKSk7
CmV4dGVybiBzdHJ1Y3Qgcndfc2VtYXBob3JlICpGQVNUQ0FMTChyd3NlbV93YWtlKHN0cnVjdCBy
d19zZW1hcGhvcmUgKikpOwoKLyoKICogdGhlIHNlbWFwaG9yZSBkZWZpbml0aW9uCiAqLwpzdHJ1
Y3Qgcndfc2VtYXBob3JlIHsKCXNpZ25lZCBsb25nCQljb3VudDsKI2RlZmluZSBSV1NFTV9VTkxP
Q0tFRF9WQUxVRQkJMHgwMDAwMDAwMAojZGVmaW5lIFJXU0VNX0FDVElWRV9CSUFTCQkweDAwMDAw
MDAxCiNkZWZpbmUgUldTRU1fQUNUSVZFX01BU0sJCTB4MDAwMGZmZmYKI2RlZmluZSBSV1NFTV9X
QUlUSU5HX0JJQVMJCSgtMHgwMDAxMDAwMCkKI2RlZmluZSBSV1NFTV9BQ1RJVkVfUkVBRF9CSUFT
CQlSV1NFTV9BQ1RJVkVfQklBUwojZGVmaW5lIFJXU0VNX0FDVElWRV9XUklURV9CSUFTCQkoUldT
RU1fV0FJVElOR19CSUFTICsgUldTRU1fQUNUSVZFX0JJQVMpCglzcGlubG9ja190CQl3YWl0X2xv
Y2s7CglzdHJ1Y3QgbGlzdF9oZWFkCXdhaXRfbGlzdDsKI2lmIFJXU0VNX0RFQlVHCglpbnQJCQlk
ZWJ1ZzsKI2VuZGlmCn07CgovKgogKiBpbml0aWFsaXNhdGlvbgogKi8KI2lmIFJXU0VNX0RFQlVH
CiNkZWZpbmUgX19SV1NFTV9ERUJVR19JTklUICAgICAgLCAwCiNlbHNlCiNkZWZpbmUgX19SV1NF
TV9ERUJVR19JTklUCS8qICovCiNlbmRpZgoKI2RlZmluZSBfX1JXU0VNX0lOSVRJQUxJWkVSKG5h
bWUpIFwKeyBSV1NFTV9VTkxPQ0tFRF9WQUxVRSwgU1BJTl9MT0NLX1VOTE9DS0VELCBMSVNUX0hF
QURfSU5JVCgobmFtZSkud2FpdF9saXN0KSBcCglfX1JXU0VNX0RFQlVHX0lOSVQgfQoKI2RlZmlu
ZSBERUNMQVJFX1JXU0VNKG5hbWUpIFwKCXN0cnVjdCByd19zZW1hcGhvcmUgbmFtZSA9IF9fUldT
RU1fSU5JVElBTElaRVIobmFtZSkKCnN0YXRpYyBpbmxpbmUgdm9pZCBpbml0X3J3c2VtKHN0cnVj
dCByd19zZW1hcGhvcmUgKnNlbSkKewoJc2VtLT5jb3VudCA9IFJXU0VNX1VOTE9DS0VEX1ZBTFVF
OwoJc3Bpbl9sb2NrX2luaXQoJnNlbS0+d2FpdF9sb2NrKTsKCUlOSVRfTElTVF9IRUFEKCZzZW0t
PndhaXRfbGlzdCk7CiNpZiBSV1NFTV9ERUJVRwoJc2VtLT5kZWJ1ZyA9IDA7CiNlbmRpZgp9Cgov
KgogKiBsb2NrIGZvciByZWFkaW5nCiAqLwpzdGF0aWMgaW5saW5lIHZvaWQgX19kb3duX3JlYWQo
c3RydWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQp7CglfX2FzbV9fIF9fdm9sYXRpbGVfXygKCQkiIyBi
ZWdpbm5pbmcgZG93bl9yZWFkXG5cdCIKTE9DS19QUkVGSVgJIiAgaW5jbCAgICAgICglJWVheClc
blx0IiAvKiBhZGRzIDB4MDAwMDAwMDEsIHJldHVybnMgdGhlIG9sZCB2YWx1ZSAqLwoJCSIgIGpz
ICAgICAgICAyZlxuXHQiIC8qIGp1bXAgaWYgd2Ugd2VyZW4ndCBncmFudGVkIHRoZSBsb2NrICov
CgkJIjE6XG5cdCIKCQkiLnNlY3Rpb24gLnRleHQubG9jayxcImF4XCJcbiIKCQkiMjpcblx0IgoJ
CSIgIHB1c2hsICAgICAlJWVjeFxuXHQiCgkJIiAgcHVzaGwgICAgICUlZWR4XG5cdCIKCQkiICBj
YWxsICAgICAgcndzZW1fZG93bl9yZWFkX2ZhaWxlZFxuXHQiCgkJIiAgcG9wbCAgICAgICUlZWR4
XG5cdCIKCQkiICBwb3BsICAgICAgJSVlY3hcblx0IgoJCSIgIGptcCAgICAgICAxYlxuIgoJCSIu
cHJldmlvdXMiCgkJIiMgZW5kaW5nIGRvd25fcmVhZFxuXHQiCgkJOiAiK20iKHNlbS0+Y291bnQp
CgkJOiAiYSIoc2VtKQoJCTogIm1lbW9yeSIsICJjYyIpOwp9CgovKgogKiBsb2NrIGZvciB3cml0
aW5nCiAqLwpzdGF0aWMgaW5saW5lIHZvaWQgX19kb3duX3dyaXRlKHN0cnVjdCByd19zZW1hcGhv
cmUgKnNlbSkKewoJaW50IHRtcDsKCgl0bXAgPSBSV1NFTV9BQ1RJVkVfV1JJVEVfQklBUzsKCV9f
YXNtX18gX192b2xhdGlsZV9fKAoJCSIjIGJlZ2lubmluZyBkb3duX3dyaXRlXG5cdCIKTE9DS19Q
UkVGSVgJIiAgeGFkZCAgICAgICUwLCglJWVheClcblx0IiAvKiBzdWJ0cmFjdCAweDAwMDBmZmZm
LCByZXR1cm5zIHRoZSBvbGQgdmFsdWUgKi8KCQkiICB0ZXN0bCAgICAgJTAsJTBcblx0IiAvKiB3
YXMgdGhlIGNvdW50IDAgYmVmb3JlPyAqLwoJCSIgIGpueiAgICAgICAyZlxuXHQiIC8qIGp1bXAg
aWYgd2Ugd2VyZW4ndCBncmFudGVkIHRoZSBsb2NrICovCgkJIjE6XG5cdCIKCQkiLnNlY3Rpb24g
LnRleHQubG9jayxcImF4XCJcbiIKCQkiMjpcblx0IgoJCSIgIHB1c2hsICAgICAlJWVjeFxuXHQi
CgkJIiAgY2FsbCAgICAgIHJ3c2VtX2Rvd25fd3JpdGVfZmFpbGVkXG5cdCIKCQkiICBwb3BsICAg
ICAgJSVlY3hcblx0IgoJCSIgIGptcCAgICAgICAxYlxuIgoJCSIucHJldmlvdXNcbiIKCQkiIyBl
bmRpbmcgZG93bl93cml0ZSIKCQk6ICIrZCIodG1wKSwgIittIihzZW0tPmNvdW50KQoJCTogImEi
KHNlbSkKCQk6ICJtZW1vcnkiLCAiY2MiKTsKfQoKLyoKICogdW5sb2NrIGFmdGVyIHJlYWRpbmcK
ICovCnN0YXRpYyBpbmxpbmUgdm9pZCBfX3VwX3JlYWQoc3RydWN0IHJ3X3NlbWFwaG9yZSAqc2Vt
KQp7CglfX3MzMiB0bXAgPSAtUldTRU1fQUNUSVZFX1JFQURfQklBUzsKCV9fYXNtX18gX192b2xh
dGlsZV9fKAoJCSIjIGJlZ2lubmluZyBfX3VwX3JlYWRcblx0IgpMT0NLX1BSRUZJWAkiICB4YWRk
ICAgICAgJSVlZHgsKCUlZWF4KVxuXHQiIC8qIHN1YnRyYWN0cyAxLCByZXR1cm5zIHRoZSBvbGQg
dmFsdWUgKi8KCQkiICBqcyAgICAgICAgMmZcblx0IiAvKiBqdW1wIGlmIHRoZSBsb2NrIGlzIGJl
aW5nIHdhaXRlZCB1cG9uICovCgkJIjE6XG5cdCIKCQkiLnNlY3Rpb24gLnRleHQubG9jayxcImF4
XCJcbiIKCQkiMjpcblx0IgoJCSIgIGRlY3cgICAgICAlJWR4XG5cdCIgLyogZG8gbm90aGluZyBp
ZiBzdGlsbCBvdXRzdGFuZGluZyBhY3RpdmUgcmVhZGVycyAqLwoJCSIgIGpueiAgICAgICAxYlxu
XHQiCgkJIiAgcHVzaGwgICAgICUlZWN4XG5cdCIKCQkiICBjYWxsICAgICAgcndzZW1fd2FrZVxu
XHQiCgkJIiAgcG9wbCAgICAgICUlZWN4XG5cdCIKCQkiICBqbXAgICAgICAgMWJcbiIKCQkiLnBy
ZXZpb3VzXG4iCgkJIiMgZW5kaW5nIF9fdXBfcmVhZFxuIgoJCTogIittIihzZW0tPmNvdW50KSwg
IitkIih0bXApCgkJOiAiYSIoc2VtKQoJCTogIm1lbW9yeSIsICJjYyIpOwp9CgovKgogKiB1bmxv
Y2sgYWZ0ZXIgd3JpdGluZwogKi8Kc3RhdGljIGlubGluZSB2b2lkIF9fdXBfd3JpdGUoc3RydWN0
IHJ3X3NlbWFwaG9yZSAqc2VtKQp7CglfX2FzbV9fIF9fdm9sYXRpbGVfXygKCQkiIyBiZWdpbm5p
bmcgX191cF93cml0ZVxuXHQiCgkJIiAgbW92bCAgICAgICUyLCUlZWR4XG5cdCIKTE9DS19QUkVG
SVgJIiAgeGFkZGwgICAgICUlZWR4LCglJWVheClcblx0IiAvKiB0cmllcyB0byB0cmFuc2l0aW9u
IDB4ZmZmZjAwMDEgLT4gMHgwMDAwMDAwMCAqLwoJCSIgIGpueiAgICAgICAyZlxuXHQiIC8qIGp1
bXAgaWYgdGhlIGxvY2sgaXMgYmVpbmcgd2FpdGVkIHVwb24gKi8KCQkiMTpcblx0IgoJCSIuc2Vj
dGlvbiAudGV4dC5sb2NrLFwiYXhcIlxuIgoJCSIyOlxuXHQiCgkJIiAgZGVjdyAgICAgICUlZHhc
blx0IiAvKiBkaWQgdGhlIGFjdGl2ZSBjb3VudCByZWR1Y2UgdG8gMD8gKi8KCQkiICBqbnogICAg
ICAgMWJcblx0IiAvKiBqdW1wIGJhY2sgaWYgbm90ICovCgkJIiAgcHVzaGwgICAgICUlZWN4XG5c
dCIKCQkiICBjYWxsICAgICAgcndzZW1fd2FrZVxuXHQiCgkJIiAgcG9wbCAgICAgICUlZWN4XG5c
dCIKCQkiICBqbXAgICAgICAgMWJcbiIKCQkiLnByZXZpb3VzXG4iCgkJIiMgZW5kaW5nIF9fdXBf
d3JpdGVcbiIKCQk6ICIrbSIoc2VtLT5jb3VudCkKCQk6ICJhIihzZW0pLCAiaSIoLVJXU0VNX0FD
VElWRV9XUklURV9CSUFTKQoJCTogIm1lbW9yeSIsICJjYyIsICJlZHgiKTsKfQoKLyoKICogaW1w
bGVtZW50IGF0b21pYyBhZGQgZnVuY3Rpb25hbGl0eQogKi8Kc3RhdGljIGlubGluZSB2b2lkIHJ3
c2VtX2F0b21pY19hZGQoaW50IGRlbHRhLCBzdHJ1Y3Qgcndfc2VtYXBob3JlICpzZW0pCnsKCV9f
YXNtX18gX192b2xhdGlsZV9fKApMT0NLX1BSRUZJWAkiYWRkbCAlMSwlMCIKCQk6Ij1tIihzZW0t
PmNvdW50KQoJCToiaXIiKGRlbHRhKSwgIm0iKHNlbS0+Y291bnQpKTsKfQoKLyoKICogaW1wbGVt
ZW50IGV4Y2hhbmdlIGFuZCBhZGQgZnVuY3Rpb25hbGl0eQogKi8Kc3RhdGljIGlubGluZSBpbnQg
cndzZW1fYXRvbWljX3VwZGF0ZShpbnQgZGVsdGEsIHN0cnVjdCByd19zZW1hcGhvcmUgKnNlbSkK
ewoJaW50IHRtcCA9IGRlbHRhOwoKCV9fYXNtX18gX192b2xhdGlsZV9fKApMT0NLX1BSRUZJWAki
eGFkZCAlMCwoJTIpIgoJCTogIityIih0bXApLCAiPW0iKHNlbS0+Y291bnQpCgkJOiAiciIoc2Vt
KSwgIm0iKHNlbS0+Y291bnQpCgkJOiAibWVtb3J5Iik7CgoJcmV0dXJuIHRtcCtkZWx0YTsKfQoK
I2VuZGlmIC8qIF9fS0VSTkVMX18gKi8KI2VuZGlmIC8qIF9JMzg2X1JXU0VNX0ggKi8K

--------------Boundary-00=_YACAQ07AV3Q2ETXDKMC3--
