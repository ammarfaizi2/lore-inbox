Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTCEPTD>; Wed, 5 Mar 2003 10:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTCEPTD>; Wed, 5 Mar 2003 10:19:03 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:17031 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267126AbTCEPS6>; Wed, 5 Mar 2003 10:18:58 -0500
Date: Thu, 6 Mar 2003 02:32:59 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64 - netfilter ipv6 compile failure
Message-ID: <20030305153259.GE2075@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried to compile the kernel and got the compile errors below (I
started the past from the first line that produced errors until the
compile bombed out). relevant part of the .config is present after the
compile output.

  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_rt.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_rt -DKBUILD_MODNAME=ip6t_rt -c -o net/ipv6/netfilter/.tmp_ip6t_rt.o net/ipv6/netfilter/ip6t_rt.c
net/ipv6/netfilter/ip6t_rt.c:14: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.c:14: warning: data definition has no type or storage class
net/ipv6/netfilter/ip6t_rt.c: In function `match':
net/ipv6/netfilter/ip6t_rt.c:145: warning: assignment from incompatible pointer type
scripts/fixdep net/ipv6/netfilter/.ip6t_rt.o.d net/ipv6/netfilter/ip6t_rt.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_rt.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_rt -DKBUILD_MODNAME=ip6t_rt -c -o net/ipv6/netfilter/.tmp_ip6t_rt.o net/ipv6/netfilter/ip6t_rt.c' > net/ipv6/netfilter/.ip6t_rt.o.tmp; rm -f net/ipv6/netfilter/.ip6t_rt.o.d; mv -f net/ipv6/netfilter/.ip6t_rt.o.tmp net/ipv6/netfilter/.ip6t_rt.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_hbh.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_hbh -DKBUILD_MODNAME=ip6t_hbh -c -o net/ipv6/netfilter/.tmp_ip6t_hbh.o net/ipv6/netfilter/ip6t_hbh.c
net/ipv6/netfilter/ip6t_hbh.c:18: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_hbh.c:18: warning: data definition has no type or storage class
scripts/fixdep net/ipv6/netfilter/.ip6t_hbh.o.d net/ipv6/netfilter/ip6t_hbh.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_hbh.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_hbh -DKBUILD_MODNAME=ip6t_hbh -c -o net/ipv6/netfilter/.tmp_ip6t_hbh.o net/ipv6/netfilter/ip6t_hbh.c' > net/ipv6/netfilter/.ip6t_hbh.o.tmp; rm -f net/ipv6/netfilter/.ip6t_hbh.o.d; mv -f net/ipv6/netfilter/.ip6t_hbh.o.tmp net/ipv6/netfilter/.ip6t_hbh.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_dst.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_dst -DKBUILD_MODNAME=ip6t_dst -c -o net/ipv6/netfilter/.tmp_ip6t_dst.o net/ipv6/netfilter/ip6t_dst.c
net/ipv6/netfilter/ip6t_dst.c:18: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_dst.c:18: warning: data definition has no type or storage class
scripts/fixdep net/ipv6/netfilter/.ip6t_dst.o.d net/ipv6/netfilter/ip6t_dst.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_dst.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_dst -DKBUILD_MODNAME=ip6t_dst -c -o net/ipv6/netfilter/.tmp_ip6t_dst.o net/ipv6/netfilter/ip6t_dst.c' > net/ipv6/netfilter/.ip6t_dst.o.tmp; rm -f net/ipv6/netfilter/.ip6t_dst.o.d; mv -f net/ipv6/netfilter/.ip6t_dst.o.tmp net/ipv6/netfilter/.ip6t_dst.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_ipv6header.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_ipv6header -DKBUILD_MODNAME=ip6t_ipv6header -c -o net/ipv6/netfilter/.tmp_ip6t_ipv6header.o net/ipv6/netfilter/ip6t_ipv6header.c
net/ipv6/netfilter/ip6t_ipv6header.c:17: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_ipv6header.c:17: warning: data definition has no type or storage class
net/ipv6/netfilter/ip6t_ipv6header.c: In function `ipv6header_match':
net/ipv6/netfilter/ip6t_ipv6header.c:54: warning: unused variable `opt'
scripts/fixdep net/ipv6/netfilter/.ip6t_ipv6header.o.d net/ipv6/netfilter/ip6t_ipv6header.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_ipv6header.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_ipv6header -DKBUILD_MODNAME=ip6t_ipv6header -c -o net/ipv6/netfilter/.tmp_ip6t_ipv6header.o net/ipv6/netfilter/ip6t_ipv6header.c' > net/ipv6/netfilter/.ip6t_ipv6header.o.tmp; rm -f net/ipv6/netfilter/.ip6t_ipv6header.o.d; mv -f net/ipv6/netfilter/.ip6t_ipv6header.o.tmp net/ipv6/netfilter/.ip6t_ipv6header.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_frag.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_frag -DKBUILD_MODNAME=ip6t_frag -c -o net/ipv6/netfilter/.tmp_ip6t_frag.o net/ipv6/netfilter/ip6t_frag.c
net/ipv6/netfilter/ip6t_frag.c:14: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_frag.c:14: warning: data definition has no type or storage class
net/ipv6/netfilter/ip6t_frag.c: In function `match':
net/ipv6/netfilter/ip6t_frag.c:162: warning: assignment from incompatible pointer type
scripts/fixdep net/ipv6/netfilter/.ip6t_frag.o.d net/ipv6/netfilter/ip6t_frag.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_frag.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_frag -DKBUILD_MODNAME=ip6t_frag -c -o net/ipv6/netfilter/.tmp_ip6t_frag.o net/ipv6/netfilter/ip6t_frag.c' > net/ipv6/netfilter/.ip6t_frag.o.tmp; rm -f net/ipv6/netfilter/.ip6t_frag.o.d; mv -f net/ipv6/netfilter/.ip6t_frag.o.tmp net/ipv6/netfilter/.ip6t_frag.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_esp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_esp -DKBUILD_MODNAME=ip6t_esp -c -o net/ipv6/netfilter/.tmp_ip6t_esp.o net/ipv6/netfilter/ip6t_esp.c
net/ipv6/netfilter/ip6t_esp.c:12: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_esp.c:12: warning: data definition has no type or storage class
net/ipv6/netfilter/ip6t_esp.c: In function `match':
net/ipv6/netfilter/ip6t_esp.c:138: warning: assignment from incompatible pointer type
scripts/fixdep net/ipv6/netfilter/.ip6t_esp.o.d net/ipv6/netfilter/ip6t_esp.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_esp.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_esp -DKBUILD_MODNAME=ip6t_esp -c -o net/ipv6/netfilter/.tmp_ip6t_esp.o net/ipv6/netfilter/ip6t_esp.c' > net/ipv6/netfilter/.ip6t_esp.o.tmp; rm -f net/ipv6/netfilter/.ip6t_esp.o.d; mv -f net/ipv6/netfilter/.ip6t_esp.o.tmp net/ipv6/netfilter/.ip6t_esp.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_ah.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_ah -DKBUILD_MODNAME=ip6t_ah -c -o net/ipv6/netfilter/.tmp_ip6t_ah.o net/ipv6/netfilter/ip6t_ah.c
net/ipv6/netfilter/ip6t_ah.c:12: warning: type defaults to `int' in declaration of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_ah.c:12: warning: data definition has no type or storage class
net/ipv6/netfilter/ip6t_ah.c: In function `match':
net/ipv6/netfilter/ip6t_ah.c:148: warning: assignment from incompatible pointer type
scripts/fixdep net/ipv6/netfilter/.ip6t_ah.o.d net/ipv6/netfilter/ip6t_ah.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_ah.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_ah -DKBUILD_MODNAME=ip6t_ah -c -o net/ipv6/netfilter/.tmp_ip6t_ah.o net/ipv6/netfilter/ip6t_ah.c' > net/ipv6/netfilter/.ip6t_ah.o.tmp; rm -f net/ipv6/netfilter/.ip6t_ah.o.d; mv -f net/ipv6/netfilter/.ip6t_ah.o.tmp net/ipv6/netfilter/.ip6t_ah.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_eui64.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_eui64 -DKBUILD_MODNAME=ip6t_eui64 -c -o net/ipv6/netfilter/.tmp_ip6t_eui64.o net/ipv6/netfilter/ip6t_eui64.c
scripts/fixdep net/ipv6/netfilter/.ip6t_eui64.o.d net/ipv6/netfilter/ip6t_eui64.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_eui64.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_eui64 -DKBUILD_MODNAME=ip6t_eui64 -c -o net/ipv6/netfilter/.tmp_ip6t_eui64.o net/ipv6/netfilter/ip6t_eui64.c' > net/ipv6/netfilter/.ip6t_eui64.o.tmp; rm -f net/ipv6/netfilter/.ip6t_eui64.o.d; mv -f net/ipv6/netfilter/.ip6t_eui64.o.tmp net/ipv6/netfilter/.ip6t_eui64.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_multiport.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_multiport -DKBUILD_MODNAME=ip6t_multiport -c -o net/ipv6/netfilter/.tmp_ip6t_multiport.o net/ipv6/netfilter/ip6t_multiport.c
scripts/fixdep net/ipv6/netfilter/.ip6t_multiport.o.d net/ipv6/netfilter/ip6t_multiport.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_multiport.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_multiport -DKBUILD_MODNAME=ip6t_multiport -c -o net/ipv6/netfilter/.tmp_ip6t_multiport.o net/ipv6/netfilter/ip6t_multiport.c' > net/ipv6/netfilter/.ip6t_multiport.o.tmp; rm -f net/ipv6/netfilter/.ip6t_multiport.o.d; mv -f net/ipv6/netfilter/.ip6t_multiport.o.tmp net/ipv6/netfilter/.ip6t_multiport.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_owner.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_owner -DKBUILD_MODNAME=ip6t_owner -c -o net/ipv6/netfilter/.tmp_ip6t_owner.o net/ipv6/netfilter/ip6t_owner.c
scripts/fixdep net/ipv6/netfilter/.ip6t_owner.o.d net/ipv6/netfilter/ip6t_owner.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_owner.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_owner -DKBUILD_MODNAME=ip6t_owner -c -o net/ipv6/netfilter/.tmp_ip6t_owner.o net/ipv6/netfilter/ip6t_owner.c' > net/ipv6/netfilter/.ip6t_owner.o.tmp; rm -f net/ipv6/netfilter/.ip6t_owner.o.d; mv -f net/ipv6/netfilter/.ip6t_owner.o.tmp net/ipv6/netfilter/.ip6t_owner.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6table_filter.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6table_filter -DKBUILD_MODNAME=ip6table_filter -c -o net/ipv6/netfilter/.tmp_ip6table_filter.o net/ipv6/netfilter/ip6table_filter.c
scripts/fixdep net/ipv6/netfilter/.ip6table_filter.o.d net/ipv6/netfilter/ip6table_filter.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6table_filter.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6table_filter -DKBUILD_MODNAME=ip6table_filter -c -o net/ipv6/netfilter/.tmp_ip6table_filter.o net/ipv6/netfilter/ip6table_filter.c' > net/ipv6/netfilter/.ip6table_filter.o.tmp; rm -f net/ipv6/netfilter/.ip6table_filter.o.d; mv -f net/ipv6/netfilter/.ip6table_filter.o.tmp net/ipv6/netfilter/.ip6table_filter.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6table_mangle.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6table_mangle -DKBUILD_MODNAME=ip6table_mangle -c -o net/ipv6/netfilter/.tmp_ip6table_mangle.o net/ipv6/netfilter/ip6table_mangle.c
scripts/fixdep net/ipv6/netfilter/.ip6table_mangle.o.d net/ipv6/netfilter/ip6table_mangle.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6table_mangle.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6table_mangle -DKBUILD_MODNAME=ip6table_mangle -c -o net/ipv6/netfilter/.tmp_ip6table_mangle.o net/ipv6/netfilter/ip6table_mangle.c' > net/ipv6/netfilter/.ip6table_mangle.o.tmp; rm -f net/ipv6/netfilter/.ip6table_mangle.o.d; mv -f net/ipv6/netfilter/.ip6table_mangle.o.tmp net/ipv6/netfilter/.ip6table_mangle.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_MARK.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_MARK -DKBUILD_MODNAME=ip6t_MARK -c -o net/ipv6/netfilter/.tmp_ip6t_MARK.o net/ipv6/netfilter/ip6t_MARK.c
scripts/fixdep net/ipv6/netfilter/.ip6t_MARK.o.d net/ipv6/netfilter/ip6t_MARK.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_MARK.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_MARK -DKBUILD_MODNAME=ip6t_MARK -c -o net/ipv6/netfilter/.tmp_ip6t_MARK.o net/ipv6/netfilter/ip6t_MARK.c' > net/ipv6/netfilter/.ip6t_MARK.o.tmp; rm -f net/ipv6/netfilter/.ip6t_MARK.o.d; mv -f net/ipv6/netfilter/.ip6t_MARK.o.tmp net/ipv6/netfilter/.ip6t_MARK.o.cmd
  gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_LOG.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_LOG -DKBUILD_MODNAME=ip6t_LOG -c -o net/ipv6/netfilter/.tmp_ip6t_LOG.o net/ipv6/netfilter/ip6t_LOG.c
scripts/fixdep net/ipv6/netfilter/.ip6t_LOG.o.d net/ipv6/netfilter/ip6t_LOG.o 'gcc -Wp,-MD,net/ipv6/netfilter/.ip6t_LOG.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ip6t_LOG -DKBUILD_MODNAME=ip6t_LOG -c -o net/ipv6/netfilter/.tmp_ip6t_LOG.o net/ipv6/netfilter/ip6t_LOG.c' > net/ipv6/netfilter/.ip6t_LOG.o.tmp; rm -f net/ipv6/netfilter/.ip6t_LOG.o.d; mv -f net/ipv6/netfilter/.ip6t_LOG.o.tmp net/ipv6/netfilter/.ip6t_LOG.o.cmd
   ld -m elf_i386  -r -o net/ipv6/netfilter/built-in.o net/ipv6/netfilter/ip6_tables.o net/ipv6/netfilter/ip6t_limit.o net/ipv6/netfilter/ip6t_mark.o net/ipv6/netfilter/ip6t_length.o net/ipv6/netfilter/ip6t_mac.o net/ipv6/netfilter/ip6t_rt.o net/ipv6/netfilter/ip6t_hbh.o net/ipv6/netfilter/ip6t_dst.o net/ipv6/netfilter/ip6t_ipv6header.o net/ipv6/netfilter/ip6t_frag.o net/ipv6/netfilter/ip6t_esp.o net/ipv6/netfilter/ip6t_ah.o net/ipv6/netfilter/ip6t_eui64.o net/ipv6/netfilter/ip6t_multiport.o net/ipv6/netfilter/ip6t_owner.o net/ipv6/netfilter/ip6table_filter.o net/ipv6/netfilter/ip6table_mangle.o net/ipv6/netfilter/ip6t_MARK.o net/ipv6/netfilter/ip6t_LOG.o
net/ipv6/netfilter/ip6t_hbh.o: In function `ipv6_ext_hdr':
net/ipv6/netfilter/ip6t_hbh.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
net/ipv6/netfilter/ip6t_hbh.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
net/ipv6/netfilter/ip6t_dst.o: In function `ipv6_ext_hdr':
net/ipv6/netfilter/ip6t_dst.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
net/ipv6/netfilter/ip6t_dst.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
net/ipv6/netfilter/ip6t_ipv6header.o: In function `ipv6_ext_hdr':
net/ipv6/netfilter/ip6t_ipv6header.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
net/ipv6/netfilter/ip6t_ipv6header.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
net/ipv6/netfilter/ip6t_frag.o: In function `ipv6_ext_hdr':
net/ipv6/netfilter/ip6t_frag.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
net/ipv6/netfilter/ip6t_frag.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
net/ipv6/netfilter/ip6t_esp.o: In function `ipv6_ext_hdr':
net/ipv6/netfilter/ip6t_esp.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
net/ipv6/netfilter/ip6t_esp.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
net/ipv6/netfilter/ip6t_ah.o: In function `ipv6_ext_hdr':
net/ipv6/netfilter/ip6t_ah.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
net/ipv6/netfilter/ip6t_rt.o(.text+0x0): first defined here
net/ipv6/netfilter/ip6t_ah.o(.bss+0x0): multiple definition of `EXPORT_NO_SYMBOLS'
net/ipv6/netfilter/ip6t_rt.o(.bss+0x0): first defined here
make[3]: *** [net/ipv6/netfilter/built-in.o] Error 1
make[2]: *** [net/ipv6/netfilter] Error 2
make[1]: *** [net/ipv6] Error 2
make: *** [net] Error 2

--- 8< ---
CONFIG_IPV6=y       
CONFIG_IPV6_PRIVACY=y

# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y                                    
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_AHESP=y
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y

CONFIG_IPV6_SCTP__=y

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y

If you need more info or for me to test patches, please yell. :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

