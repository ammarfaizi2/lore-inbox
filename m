Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSLNElH>; Fri, 13 Dec 2002 23:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSLNElH>; Fri, 13 Dec 2002 23:41:07 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:19598 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267048AbSLNElG> convert rfc822-to-8bit; Fri, 13 Dec 2002 23:41:06 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.50 enable USB - ethernet?
Date: Fri, 13 Dec 2002 20:48:20 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212132048.21047.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems especially strange that kmalloc is not exported

make -f scripts/Makefile.modinst obj=arch/i386/lib
echo /sbin/depmod
/sbin/depmod
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.50; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.50/kernel/dummy.o
depmod:         __kfree_skb
depmod:         ether_setup
depmod:         kmalloc
depmod:         unregister_netdev
depmod:         register_netdev
depmod:         dev_alloc_name
depmod:         kfree

