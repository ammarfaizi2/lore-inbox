Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131882AbRAGOPy>; Sun, 7 Jan 2001 09:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbRAGOPo>; Sun, 7 Jan 2001 09:15:44 -0500
Received: from c-972d.020-11-6b73642.cust.bredbandsbolaget.se ([213.112.13.12]:62217
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131882AbRAGOP2>; Sun, 7 Jan 2001 09:15:28 -0500
Message-ID: <3A5886B7.79440F06@xpress.se>
Date: Sun, 07 Jan 2001 15:09:43 +0000
From: Johan Groth <jgroth@xpress.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-storm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@gams.at>
CC: Tom Leete <tleete@mountain.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel compile trouble
In-Reply-To: <200101071252.NAA23737@frodo.gams.co.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> 
> In message <3A57FA27.348780BC@mountain.net>, Tom Leete wrote:
> >You don't show your .config, but I'll make a wild guess you're compiling for
> >SMP+3DNow (probably by selecting Athlon processor). If so pick one of:
> 
> For me it is the same.
> 
> >       a) Deselect SMP, make clean make dep, etc.
> 
> gives:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.0/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -malign-functions=4     -DEXPORT_SYMTAB -c ksyms.c
> In file included from /usr/src/linux-2.4.0/include/linux/modversions.h:93,
>                  from /usr/src/linux-2.4.0/include/linux/module.h:21,
>                  from ksyms.c:14:
> /usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:84: warning: `cpu_data' redefined
> /usr/src/linux-2.4.0/include/asm/processor.h:78: warning: this is the location of the previous definition
> /usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:88: warning: `smp_num_cpus' redefined
> /usr/src/linux-2.4.0/include/linux/smp.h:80: warning: this is the location of the previous definition
> /usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:90: warning: `cpu_online_map' redefined
> /usr/src/linux-2.4.0/include/linux/smp.h:88: warning: this is the location of the previous definition
> /usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:92: warning: `synchronize_irq' redefined
> /usr/src/linux-2.4.0/include/asm/hardirq.h:37: warning: this is the location of the previous definition
> /usr/src/linux-2.4.0/include/linux/modules/i386_ksyms.ver:104: warning: `smp_call_function' redefined
> /usr/src/linux-2.4.0/include/linux/smp.h:87: warning: this is the location of the previous definition
> In file included from /usr/src/linux-2.4.0/include/linux/modversions.h:117,
>                  from /usr/src/linux-2.4.0/include/linux/module.h:21,
>                  from ksyms.c:14:
> /usr/src/linux-2.4.0/include/linux/modules/ksyms.ver:504: warning: `del_timer_sync' redefined
> /usr/src/linux-2.4.0/include/linux/timer.h:34: warning: this is the location of the previous definition
> /usr/src/linux-2.4.0/include/linux/kernel_stat.h: In function `kstat_irqs':
> In file included from ksyms.c:17:
> /usr/src/linux-2.4.0/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared (first use in this function)
> /usr/src/linux-2.4.0/include/linux/kernel_stat.h:48: (Each undeclared identifier is reported only once
> /usr/src/linux-2.4.0/include/linux/kernel_stat.h:48: for each function it appears in.)
> make[2]: *** [ksyms.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.4.0/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.0/kernel'
> make: *** [_dir_kernel] Error 2
> 
> >       b) Downgrade processor selection to i686 or k6
> 
> Does not help (for me).
> 
> >       c) See the patch I posted here Tuesday.
> 
> see above - SMP not selected.

To answer you both: It did help by deselecting SMP and APIC & IO-APIC
but only by first doing make mrproper (I did not test make clean) and
loading a saved config and after that deselecting SMP and APIC and then
make dep && make bzImage.

Thank you for your help.

Regards,
Johan

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   "Better to ask questions and seem stupid
    than not to ask questions and remain stupid" -Unknown
           Johan Groth <jgroth@xpress.se> Kupolen Data
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
