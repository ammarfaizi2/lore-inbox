Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTHTQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTHTQ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:58:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:54982 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262071AbTHTQ6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:58:14 -0400
Date: Wed, 20 Aug 2003 09:54:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linuxmodule@altern.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 module compilation
Message-Id: <20030820095408.68d9dea9.rddunlap@osdl.org>
In-Reply-To: <S261663AbTHTQkp/20030820164045Z+1122@vger.kernel.org>
References: <S261663AbTHTQkp/20030820164045Z+1122@vger.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 18:39:19 +0200 (CEST) <linuxmodule@altern.org> wrote:

| I am trying to compile a module on 2.6.0-test3 kernel. The makefile i am using is a pretty normal one : 
| 
| CFLAGS = -D__KERNEL__ -DMODULE -I/usr/src/linux-2.6.0-test3/include -O
| dummy.o: dummy.c
| 
| The module i am trying to compile is taken from the kernel itself (dummy network device driver). The
| compilation works flawlessly but when i try to insert the module i get : invalid module format.
| What am i doing wrong because i have modutils and module-init and both work, since the same module (dummy)
| compiled with the kernel itself can be inserted and removed without the previous error message.
| Is there something i should know about the compilation process ? The kernel-compiled module (dummy.ko) has
| about 10 Kbytes and dummy.ko compiled by me has only 2 Kbytes :(

Please wrap lines near 70-72 characters.

Can you try a Makefile and instructions like this?

# makefile for dummy module
# usage:
# cd /path/to/kernel/source && make SUBDIRS=/path/to/source/dummymod/ modules

obj-m := dummy.o

clean-files := *.o


--
~Randy   [MOTD:  Always include kernel version.]
"Everything is relative."
