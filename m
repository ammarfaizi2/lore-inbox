Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWISRdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWISRdm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWISRdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:33:42 -0400
Received: from hera.kernel.org ([140.211.167.34]:27840 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030384AbWISRdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:33:41 -0400
Date: Tue, 19 Sep 2006 17:32:53 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Mikael Pettersson <mikpe@it.uu.se>,
       David Miller <davem@davemloft.net>
Subject: Linux 2.4.34-pre3
Message-ID: <20060919173253.GA25470@hera.kernel.org>
Reply-To: w@1wt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

I've been a little bit silent and quite busy too. As announced with -pre2,
here comes -pre3 with only GCC4 fixes. Other fixes I received are minor
and can wait for -pre4. I really want people to test -pre3 without adding
any noise to the test. There should be *no* regression at all with existing
compilers.

Gcc 4.1 is known to build x86, x86_64, ppc, sparc64, and sparc. Only sparc
has received no testing yet, while sparc64 is OK. It is possible that some
sparc/sparc64 drivers have not been caught because of undetected options
combinations (Davem CC'd for any possible advice on this mater). Status
for other archs is unknown but at least must not be affected for existing
setups.

You will notice that most of the changes below appear under my name while
I do not deserve any credit for the changes. It is just because I've cut
all the fixes to sort them, and committed them myself individually. But
the real work has been done by Mikael.

We have worked *very* carefully on this merge, and we hope to get all
possible feedback. People who encounter build problems on archs listed
above are free to report them, possibly with the fix. When providing a
fix, *please* provide the whole error output in the commit message so
that we can track what has been fixed. People who want to include support
for other archs will have to provide patches, as (at least for me) we
are not equipped to build on other archs (except for alpha when my RAM
arrives).

I plan to wait up to the end of this month before providing -pre4 if there
is no feedback. Important fixes will be subject to another -stable release
anyway, so it's safe to wait for feedback here.

Now I've fixed my release scripts, so the changelog and patch should be
OK ;-)

Best regards,
Willy


Summary of changes from v2.4.34-pre2 to v2.4.34-pre3
============================================

Mikael Pettersson:
      [GCC4] SPARC64: fix UP build error in arch/sparc64/mm/init.c

Willy Tarreau:
      [GCC4] add preliminary support for GCC 4 (Mikael Pettersson)
      [GCC4] fix build error in include/linux/generic_serial.h
      [GCC4] fix build error in include/net/irda/qos.h
      [GCC4] fix build error in include/linux/fsfilter.h
      [GCC4] fix build error in include/linux/intermezzo_fs.h
      [GCC4] fix build error in include/net/udp.h
      [GCC4] fix build error in include/net/irda/irttp.h
      [GCC4] fix build error in include/net/irda/irlan_event.h
      [GCC4] fix build error in include/asm-ppc/spinlock.h
      [GCC4] fix build error in fs/intermezzo/presto.c
      [GCC4] fix build error in net/ipv6/ip6_fib.c
      [GCC4] fix build error in net/ipv6/sysctl_net_ipv6.c
      [GCC4] fix build error in net/khttpd/prototypes.h
      [GCC4] fix build error in drivers/block/nbd.c
      [GCC4] fix build error in drivers/block/xd.c
      [GCC4] fix build error in drivers/block/paride/pd.c
      [GCC4] fix build error in drivers/char/sonypi.h
      [GCC4] fix build error in drivers/char/sonypi.h
      [GCC4] fix build error in drivers/char/tpqic02.c
      [GCC4] fix build error in drivers/char/drm-4.0/drmP.h
      [GCC4] fix build error in drivers/char/rio/rio_linux.c
      [GCC4] fix build error in drivers/net/acenic.c
      [GCC4] fix build error in drivers/net/wan/comx.h
      [GCC4] fix build error in drivers/net/3c507.c
      [GCC4] fix build error in drivers/net/arlan.c
      [GCC4] fix build error in drivers/net/irda/donauboe.c
      [GCC4] fix build error in drivers/net/sk98lin/skvpd.c
      [GCC4] fix build error in drivers/net/wan/comx-hw-comx.c
      [GCC4] fix build error in drivers/net/wan/sdladrv.c
      [GCC4] fix build error in drivers/net/wan/sdlamain.c
      [GCC4] fix build error in drivers/net/wan/sdla_fr.c
      [GCC4] fix build error in drivers/net/hamradio/baycom_epp.c
      [GCC4] fix build error in drivers/net/hamradio/soundmodem/sm.h
      [GCC4] fix build error in drivers/scsi/advansys.c
      [GCC4] fix build error in drivers/scsi/atp870u.c
      [GCC4] fix build error in drivers/scsi/cpqfcTS*
      [GCC4] fix build error in drivers/ide/legacy/hd.c
      [GCC4] fix build error in drivers/cdrom/sbpcd.c
      [GCC4] fix build error in drivers/md/lvm-internal.h
      [GCC4] fix build error in drivers/atm/iphase.c
      [GCC4] fix build error in drivers/atm/fore200e.c
      [GCC4] fix build error in drivers/isdn/eicon/eicon.h
      [GCC4] fix build error in drivers/isdn/hisax/hfc_pci.c
      [GCC4] fix build error in drivers/i2c/i2c-core.c
      [GCC4] fix build error in drivers/i2c/i2c-proc.c
      [GCC4] fix build error in drivers/media/video/videodev.c
      [GCC4] fix build error in drivers/usb/audio.c
      [GCC4] fix build error in drivers/ieee1394/highlevel.c
      [GCC4] fix build error in drivers/media/video/bttvp.h
      [GCC4] fix build error in drivers/sound/wavfront.c
      [GCC4] fix warning in include/linux/atalk.h
      [GCC4] fix warnings in include/linux/isdnif.h
      [GCC4] fix warnings in include/net/dn_dev.h
      [GCC4] fix warnings in include/net/dn_nsp.h
      [GCC4] fix warnings in sdla.h and if_frad.h
      [GCC4] fix warnings in sdla_x25.c and sdla_x25.h
      [GCC4] fix warnings in include/linux/wanpipe.h
      [GCC4] fix warnings in drivers/char/sx.c
      [GCC4] fix warning in drivers/char/ip2/i2lib.c
      [GCC4] fix warnings in drivers/net/de4x5,depca,arcnet
      [GCC4] fix warnings in drivers/isdn/eicon/eicon*.h
      [GCC4] fix warnings in drivers/isdn/hisax/hisax.h
      [GCC4] fix build in drivers/atm/horizon.c
      [GCC4] fix build error in drivers/net/rrunner.c
      [GCC4] SPARC64: fix build error in arch/sparc64/kernel/smp.c
      [GCC4] SPARC64: fix build error in arch/sparc64/kernel/time.c
      [GCC4] SPARC64: fix build error in drivers/sbus/char/pcikbd.c
      [GCC4] SPARC: fix build error in arch/sparc/kernel/signal.c
      [GCC4] SPARC: fix build error in arch/sparc/kernel/time.c
      [GCC4] SPARC: fix build error in drivers/fc4/soc.c
      Merge branch 'gcc4'
      Change VERSION to 2.4.34-pre3

