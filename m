Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130472AbQJ0U4W>; Fri, 27 Oct 2000 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQJ0U4M>; Fri, 27 Oct 2000 16:56:12 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:42704 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130472AbQJ0Uz7>; Fri, 27 Oct 2000 16:55:59 -0400
Date: Fri, 27 Oct 2000 21:55:56 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Remi Turk <remi@a2zis.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Not reproducable crc error at boot :-(
In-Reply-To: <39F9E6C7.1C51B730@a2zis.com>
Message-ID: <Pine.SOL.3.96.1001027215120.18154C-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would suggest to increase the 8bit waitstates in the BIOS by +1 (or
more). - you might have to increase the 16bit waitstates as well (or
instead of the 8bit ones).

It cured such a problem for me: - A Intel Pentium PC that had run Netware
3.12 perfectly happily for years didn't boot up with a CRC error after
installing RedHat 7.0 on it. - Increasing the 8bit waitstates from 1 to 2
cured the problem completely and the PC is rocksolid now. - The PC also
ran Windows quite happily (I installed it after the trouble with Linux
just to see if it would work - I was worried about the hardware having
gone dodgy.)

Hope this helps.

Regards,

	Anton

On Fri, 27 Oct 2000, Remi Turk wrote:

> Hi folks,
> when booting pre5 I got a crc-error while uncompressing
> the kernel this morning. (/usr/src/linux/lib/inflate.c:1166 AFAICS)
> Rebooting didn't trigger it again and it's the first time I ever saw it.
> 
> I've never had any SIG11 problems while compiling kernels so I wouldn't
> expect bad RAM. (Normal people probably run Seti@home,
> I run "while make bzImage; do date >> /tmp/kcompile; make clean; done"
> ;-)
> 
> OTOH, it's not reproducable which seems an indicator for hardware
> trouble :-(
> 
> Does anybody have any ideas?
> 
> Linux version 2.4.0-test10-pre5 (src@localhost.localdomain)
> (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))
> #1 Tue Oct 24 17:14:24 CEST 2000
> 
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 5
> model		: 8
> model name	: AMD-K6(tm) 3D processor
> stepping	: 0
> cpu MHz		: 350.000809
> cache size	: 64 KB
> fdiv_bug	: no
> hlt_bug		: no
> sep_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr mce cx8 sep mmx 3dnow
> bogomips	: 699.60
> 
> -- 
> Linux 2.4.0-test10-pre5 #1 Tue Oct 24 17:14:24 CEST 2000
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-- 

Anton Altaparmakov       Phone: +44-(0)1223-333541 (lab)
Christ's College         eMail: AntonA@bigfoot.com
Cambridge CB2 3BU          WWW: http://www-stu.christs.cam.ac.uk/~aia21/
United Kingdom             ICQ: 8561279

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
