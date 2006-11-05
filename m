Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWKEMQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWKEMQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 07:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWKEMQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 07:16:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40720 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932682AbWKEMQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 07:16:38 -0500
Date: Sun, 5 Nov 2006 13:16:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.31-rc1
Message-ID: <20061105121639.GB5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.30:
- CVE-2006-4572: fix ip6_tables bypass bugs
- CVE-2006-5174: s390: fix user readable uninitialised kernel memory
- CVE-2006-5619: IPV6: fix lockup via /proc/net/ip6_flowlabel


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.30:

Adrian Bunk (1):
      Linux 2.6.16.31-rc1

Al Viro (1):
      fix RARP ic_servaddr breakage

James Morris (1):
      [IPV6]: fix lockup via /proc/net/ip6_flowlabel (CVE-2006-5619)

Martin Schwidefsky (2):
      [S390] fix user readable uninitialised kernel memory (CVE-2006-5174)
      [S390] fix user readable uninitialised kernel memory, take 2.

Neil Brown (1):
      knfsd: Fix race that can disable NFS server.

Patrick McHardy (2):
      [NETFILTER]: Fix ip6_tables protocol bypass bug (CVE-2006-4572)
      [NETFILTER]: Fix ip6_tables extension header bypass bug (CVE-2006-4572)

Shaohua Li (1):
      ACPI: enable SMP C-states on x86_64

Thomas Gleixner (1):
      posix-cpu-timers: prevent signal delivery starvation


 Makefile                            |    2 
 arch/s390/lib/uaccess.S             |   12 ++++
 arch/s390/lib/uaccess64.S           |   12 ++++
 arch/x86_64/kernel/acpi/Makefile    |    1 
 arch/x86_64/kernel/acpi/processor.c |   72 ----------------------------
 include/asm-x86_64/acpi.h           |    2 
 kernel/posix-cpu-timers.c           |   27 ++++++++--
 net/ipv4/ipconfig.c                 |    2 
 net/ipv6/ip6_flowlabel.c            |    2 
 net/ipv6/netfilter/ip6_tables.c     |   21 +++++---
 net/ipv6/netfilter/ip6t_ah.c        |    7 ++
 net/ipv6/netfilter/ip6t_dst.c       |    9 ++-
 net/ipv6/netfilter/ip6t_frag.c      |    7 ++
 net/ipv6/netfilter/ip6t_hbh.c       |    9 ++-
 net/ipv6/netfilter/ip6t_rt.c        |    7 ++
 net/sunrpc/svcsock.c                |    2 
 16 files changed, 96 insertions(+), 98 deletions(-)

