Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUGBPjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUGBPjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUGBPjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:39:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:42171 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263184AbUGBPjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:39:19 -0400
Date: Fri, 2 Jul 2004 08:34:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Dependant modules question
Message-Id: <20040702083457.7677d0e9.rddunlap@osdl.org>
In-Reply-To: <40E56E96.3050702@vlnb.net>
References: <40E556E5.90708@vlnb.net>
	<Pine.LNX.4.53.0407020952270.3789@chaos>
	<40E56E96.3050702@vlnb.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jul 2004 18:17:58 +0400 Vladislav Bolkhovitin wrote:

| Richard B. Johnson wrote:
| > Did you execute `depmod -a` after putting your modules into the
| > default  directories and their information into /etc/modules.conf ?
|  >
| > Example:
| > /etc/modules.conf
| > alias char-major-177  module-a		# First to load
| > alias char-major-177  module-b		# Second to load
| > alias char-major-177  off		# All done
| > 
| > 
| > # cp module-a.o /lib/modules/`uname -r`/kernel/drivers/char
| > # cp module-b.o /lib/modules/`uname -r`/kernel/drivers/char
| > # depmod -a
| > 
| > The first time anybody tries to access a device with the major
| > number of 177, its modules will be loaded in the correct order
| > by modprobe.
| > 
| > Cheers,
| > Dick Johnson
| > Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
| >             Note 96.31% of all statistics are fiction.
| 
| Sure, I did. That works fine if A is built in the kernel tree (i.e. the 
| sources of A stays there), not when both A and B are external modules.
| 
| Actually, the problem is a bit different: compiled B know nothing about 
| A and doesn't reffer to it, so depmod and friends can't help. Ever if A 
| already loaded, B refused to load (can't find the symbols). I suspect, I 
| need to add something in the Makefile of A/B/both. But what?

Rusty's module testsuite has a sample/test that might help you.
Look in http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
for module-init-tools-testsuite-3.0.tar.gz  (or bz2).

--
~Randy
