Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSKBPE5>; Sat, 2 Nov 2002 10:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbSKBPE4>; Sat, 2 Nov 2002 10:04:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5636 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261271AbSKBPEw>;
	Sat, 2 Nov 2002 10:04:52 -0500
Date: Sat, 2 Nov 2002 15:11:21 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 build failures
Message-ID: <20021102151121.GA731@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 14:56:29 up  3:14,  1 user,  load average: 0.55, 0.45, 0.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(On x86 Debian/sid)

1) Device mapper:
 gcc -Wp,-MD,drivers/md/.dm-ioctl.o.d -D__KERNEL__ -Iinclude -Wall
 -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
 -march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
 -iwithprefix include    -DKBUILD_BASENAME=dm_ioctl   -c -o
 drivers/md/dm-ioctl.o drivers/md/dm-ioctl.c
 drivers/md/dm-ioctl.c: In function `create':
 drivers/md/dm-ioctl.c:588: incompatible type for argument 1 of
 `set_device_ro'
 drivers/md/dm-ioctl.c: In function `reload':
 drivers/md/dm-ioctl.c:874: incompatible type for argument 1 of
 `set_device_ro'
 make[2]: *** [drivers/md/dm-ioctl.o] Error 1
 make[1]: *** [drivers/md] Error 2
 make: *** [drivers] Error 2

2) NFSv4 server

fs/nfsd/nfs4proc.c: In function `nfsd4_write':
fs/nfsd/nfs4proc.c:484: warning: passing arg 4 of `nfsd_write' from
incompatible pointer type
fs/nfsd/nfs4proc.c:484: warning: passing arg 6 of `nfsd_write' makes
integer from pointer without a cast
fs/nfsd/nfs4proc.c:484: too few arguments to function `nfsd_write'
fs/nfsd/nfs4proc.c: In function `nfsd4_proc_compound':
fs/nfsd/nfs4proc.c:568: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
make[2]: *** [fs/nfsd/nfs4proc.o] Error 1

(Niggle: NFSv4 server support is hidden until you select v3 support,
unlike v4 client support).

3) Niggles in qconf

I like qconf a lot more than the old tk based xconfig - but I do have a
few niggles:
  a) The window starts very small
	b) In split window mode, the arrows in the right hand window don't
	seem to always work right.  For example in Bus options->support for
	hot pluggable.  When I click on the 'PCMCIA/CardBus support' arrow
	the right hand window contents are replaced with just the
	PCMCIA/Cardbus enabling rather than expanding in the existing list. In
	addition there appears to be no way to get the standard Bus Option
	right screen back without selecting something else in the left hand
	pane and then selecting Bus options again.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
