Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311635AbSCNSD1>; Thu, 14 Mar 2002 13:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311699AbSCNSDR>; Thu, 14 Mar 2002 13:03:17 -0500
Received: from ciani.phy.uic.edu ([131.193.191.66]:3968 "EHLO
	ciani.phy.uic.edu") by vger.kernel.org with ESMTP
	id <S311635AbSCNSDC>; Thu, 14 Mar 2002 13:03:02 -0500
Date: Thu, 14 Mar 2002 12:02:57 -0600 (CST)
From: "Anthony J. Ciani" <tony@ciani.phy.uic.edu>
To: linux-kernel@vger.kernel.org
Subject: do_BUG undefined in 3c509.o and (v)fat.o
Message-ID: <Pine.LNX.4.21.0203141155560.23653-100000@ciani.phy.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling 2.4.16 with verbose BUG() modules 3c509.o, fat.o and vfat.o
compiled with do_BUG as an undefined symbol.
nm /lib/modules/2.4.16/kernel/drivers/net/3c509.o |grep BUG returns
U do_BUG
Same for fat.o and vfat.o. 

nm /usr/src/linux/vmlinux |grep BUG returns
c01e6833 ? __kstrtab_do_BUG 
c01ed7e0 ? __ksymtab_do_BUG
c0110474 T do_BUG

The modules and kernel were built at the same time (modules following
kernel)

-- 
------------------------------------------------------------
              Anthony Ciani (aciani1@uic.edu)
             Computational Solid State Physics
   Department of Physics, University of Illinois, Chicago
              http://ciani.phy.uic.edu/~tony
------------------------------------------------------------

