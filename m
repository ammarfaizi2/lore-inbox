Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136665AbREIQyd>; Wed, 9 May 2001 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136679AbREIQyN>; Wed, 9 May 2001 12:54:13 -0400
Received: from srvr20.engin.umich.edu ([141.213.75.22]:48565 "EHLO
	srvr20.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S136665AbREIQyD>; Wed, 9 May 2001 12:54:03 -0400
Message-Id: <200105091654.MAA18672@xor.engin.umich.edu>
From: marius@umich.edu (marius aamodt eriksen)
To: linux-kernel@vger.kernel.org
Subject: odd insmod problem
X-um-uniqname: beriksen
X-Mailer: mh 6.8
Date: Wed, 09 May 2001 12:54:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi -

when i insmod the openafs module

   insmod /usr/vice/etc/modload/libafs-2.4.4.o

i get a whole bunch (50 in fact) unresolved symbols.  going through
some of them, i can see that they do in fact exist.  for example:

   root@gone:~ > grep inode_change_ok /proc/ksyms 
   c013ff20 inode_change_ok_R66fc5011
   root@gone:~ > grep inode_change_ok /boot/System.map
   c013ff20 T inode_change_ok
   c028f399 ? __kstrtab_inode_change_ok
   c0298d40 ? __ksymtab_inode_change_ok

so everything is in fact looking good.  any ideas?

marius.

--
marius@{umich.edu,crockster.net,linux.com}, http://www.citi.umich.edu/u/marius
