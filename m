Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264307AbRFSPXJ>; Tue, 19 Jun 2001 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbRFSPW7>; Tue, 19 Jun 2001 11:22:59 -0400
Received: from pD9E16C60.dip.t-dialin.net ([217.225.108.96]:6895 "EHLO
	tolot.escape.de") by vger.kernel.org with ESMTP id <S264300AbRFSPWv>;
	Tue, 19 Jun 2001 11:22:51 -0400
Date: Tue, 19 Jun 2001 17:22:19 +0200
From: Jochen Striepe <jochen@tolot.escape.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre4
Message-ID: <20010619172219.A18744@tolot.escape.de>
In-Reply-To: <20010619152912.A23175@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010619152912.A23175@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.19i
X-Editor: vim/5.8.3
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

On 19 Jun 2001, Alan Cox <laughing@shared-source.org> wrote:
> 
> 2.2.20pre4

Just to keep you informed... (I think there was a saying that there was
interest in experiences with compiling the kernel with non-recommended
gcc's ...)

I tried the newly released gcc-3.0 compiling 2.2.20pre4 (yes, I _know_ it
is not recommended): 

/usr/src/linux/include/linux/signal.h: In function `siginitset':
/usr/src/linux/include/linux/signal.h:193: warning: deprecated use of label at end of compound statement
/usr/src/linux/include/linux/signal.h: In function `siginitsetinv':
/usr/src/linux/include/linux/signal.h:205: warning: deprecated use of label at end of compound statement
sched.c: At top level:
sched.c:52: conflicting types for `xtime'
/usr/src/linux/include/linux/sched.h:509: previous declaration of `xtime'
sched.c: In function `schedule':
sched.c:739: warning: deprecated use of label at end of compound statement
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.2.20pre4/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.2.20pre4/kernel'
make: *** [_dir_kernel] Error 2


$ sh /usr/src/linux/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tolot 2.4.6-pre3 #1 Wed Jun 13 09:55:57 CEST 2001 i586 unknown
 
Gnu C                  3.0
Gnu make               3.79.1
binutils               2.11.1
util-linux             2.11f
mount                  2.11f
modutils               2.4.6
e2fsprogs              1.21
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         nls_utf8 nls_iso8859-15 nls_iso8859-2
nls_iso8859-1 nls_cp852 nls_cp850 nls_cp437 floppy sr_mod sg isofs
ne2k-pci 8390 ide-cd cdrom adlib_card opl3 sb sb_lib uart401 sound
soundcore ppp_generic slhc lp parport serial


So long,

Jochen.

-- 
Cahn's Axiom:
        When all else fails, read the instructions.
