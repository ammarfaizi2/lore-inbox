Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264763AbUG2TRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbUG2TRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUG2TRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:17:52 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:28363 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265027AbUG2TOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:14:51 -0400
Date: Thu, 29 Jul 2004 12:14:47 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH 2.6-BK] [ARM] Trivial ARM fixes for 2.6.8
Message-ID: <20040729191447.GA10367@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus

Russell King is out vacationing for the next 2 weeks so I can't 
push any ARM updates through him and I have have some trivial 
fixes that I'd like to get upstream into 2.6.8.  If you're OK
with pulling them directly from me, please do a

	bk pull bk://dsaxena.bkbits.net/linux-2.6-for-rmk

This will update the following files:

 arch/arm/mach-ixp4xx/common-pci.c      |    2 ++
 arch/arm/mach-ixp4xx/coyote-setup.c    |    8 ++++++--
 arch/arm/mach-ixp4xx/ixdp425-setup.c   |   10 +++++++---
 arch/arm/mach-ixp4xx/prpmc1100-setup.c |    8 ++++++--
 include/asm-arm/bitops.h               |    2 +-
 5 files changed, 22 insertions(+), 8 deletions(-)

through these ChangeSets:

<dsaxena@plexity.net> (04/07/16 1.1784.14.4)
   [ARM] Fix _find_next_bit_be prototype to use 'const' qualifier
   
   _find_next_bit_be() does not have a 'const' qualifier for the first 
   argument, so we get the following warning for a very large number
   of files:
   
   In file included from include/linux/sched.h:15,
                    from include/linux/module.h:10,
                    from drivers/mtd/maps/ixp2000.c:24:
   include/linux/cpumask.h: In function `__next_cpu':
   include/linux/cpumask.h:216: warning: passing arg 1 of `_find_next_bit_be' 
   discards qualifiers from pointer target type
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/07/15 1.1784.14.3)
   [ARM] Export ixp42xx_pci_read/write so PCI driver modules load
   
   Originally found by Thomas Winkler <winkler@iti.tu-graz.ac.at>
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

<dsaxena@plexity.net> (04/07/07 1.1784.14.1)
   [ARM] IXP4xx: platform_add_device() to platform_add_devices() conversion
   
   Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

Tnx!
~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
