Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTI3QdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTI3QdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:33:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:55434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbTI3QdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:33:16 -0400
Date: Tue, 30 Sep 2003 09:25:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mrproper@ximian.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: make install problems
Message-Id: <20030930092511.542b8022.rddunlap@osdl.org>
In-Reply-To: <1064938690.1575.7.camel@localhost.localdomain>
References: <1064927778.1575.0.camel@localhost.localdomain>
	<20030930081459.01f447bf.rddunlap@osdl.org>
	<1064935781.1575.5.camel@localhost.localdomain>
	<20030930083415.06f155ba.rddunlap@osdl.org>
	<1064938690.1575.7.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 12:18:10 -0400 Kevin Breit <mrproper@ximian.com> wrote:

| On Tue, 2003-09-30 at 11:34, Randy.Dunlap wrote:
| > On Tue, 30 Sep 2003 11:29:42 -0400 Kevin Breit <mrproper@ximian.com> wrote:
| > 
| > | On Tue, 2003-09-30 at 11:14, Randy.Dunlap wrote:
| > | > On Tue, 30 Sep 2003 09:16:19 -0400 Kevin Breit <mrproper@ximian.com> wrote:
| > | > 
| > | > | Hey,
| > | > | 	I setup a test6 kernel without module support.  I did a make install
| > | > | and got:
| > | > | 
| > | > | Kernel: arch/i386/boot/bzImage is ready
| > | > | sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6
| > | > | arch/i386/boot/bzImage System.map ""
| > | > | /lib/modules/2.6.0-test6 is not a directory.
| > | > | mkinitrd failed
| > | > | 
| > | > | How can I fix this?
| > | > 
| > | > We've seen this before, and I thought that we had determined that
| > | > it was a tools problem.  Is "depmod" in $PATH the depmod from
| > | > modutils or the one from module-init-tools?
| > | > I.e., what does 'depmod -V' say?
| > | 
| > | modutils-2.4.22-8
| > | 
| > | [root@kbreit linux-2.6.0-test6]# depmod -V
| > | depmod version 2.4.22
| > | 
| > | 
| > | > and what execs mkinitrd?  I don't find it with a quick grep.
| > | 
| > | No clue
| > 
| > You need to use module-init-tools with 2.6.x, not modutils.
| > You can find them at
| >   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
| > Just get the latest version.
| 
| Why do I need this for a moduleless kernel?

arch/i386/boot/Makefile for 'make install' runs arch/i386/boot/install.sh.
This latter script runs /sbin/installkernel or ~/bin/installkernel.
You (user) control the latter one (if present).
Your distro controls the former one, so I can't say what's in your
system's /sbin/installkernel file.
In my /sbin/installkernel, I can see that using it with a "-i"
option tells it not to generated initrd files.
YMMV.

--
~Randy
