Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTDMNxm (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 09:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTDMNxm (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 09:53:42 -0400
Received: from lucidpixels.com ([66.45.37.187]:6787 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263515AbTDMNxl (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 09:53:41 -0400
Date: Sun, 13 Apr 2003 10:05:27 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p300
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 ipv6 compile error
Message-ID: <Pine.LNX.4.51.0304131004230.31429@p300>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 2.95.3
Latest binutils.

make -C ipv6/netfilter
make[2]: Entering directory `/usr/src/linux-2.4.20/net/ipv6/netfilter'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.20/net/ipv6/netfilter'
rm -f netfilter.o
ld -m elf_i386  -r -o netfilter.o ip6_tables.o ip6t_limit.o ip6t_mark.o
ip6t_length.o ip6t_mac.o ip6t_rt.o ip6t_hbh.o ip6t_dst.o ip6t_ipv6header.o
ip6t_frag.o ip6t_esp.o ip6t_ah.o ip6t_eui64.o ip6t_multiport.o
ip6t_owner.o ip6table_filter.o ip6table_mangle.o ip6t_MARK.o ip6_queue.o
ip6t_LOG.o
ip6t_hbh.o: In function `ipv6_ext_hdr':
ip6t_hbh.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
ip6t_dst.o: In function `ipv6_ext_hdr':
ip6t_dst.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
ip6t_ipv6header.o: In function `ipv6_ext_hdr':
ip6t_ipv6header.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
ip6t_frag.o: In function `ipv6_ext_hdr':
ip6t_frag.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
ip6t_esp.o: In function `ipv6_ext_hdr':
ip6t_esp.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
ip6t_ah.o: In function `ipv6_ext_hdr':
ip6t_ah.o(.text+0x0): multiple definition of `ipv6_ext_hdr'
ip6t_rt.o(.text+0x0): first defined here
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20/net/ipv6/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/net/ipv6/netfilter'
make[1]: *** [_subdir_ipv6/netfilter] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/net'
make: *** [_dir_net] Error 2
Command exited with non-zero status 2
23.21user 2.53system 0:27.85elapsed 92%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (38979major+27482minor)pagefaults 0swaps
root@p300:/usr/src/linux#
