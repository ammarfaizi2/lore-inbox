Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272372AbTGYWjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272373AbTGYWjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:39:11 -0400
Received: from smtp.terra.es ([213.4.129.129]:31918 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S272372AbTGYWjJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:39:09 -0400
Date: Sat, 26 Jul 2003 00:54:19 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G3
Message-Id: <20030726005419.16b622af.diegocg@teleline.es>
In-Reply-To: <20030725231314.A1073@ss1000.ms.mff.cuni.cz>
References: <Pine.LNX.4.44.0307252146550.16235-100000@localhost.localdomain>
	<20030725231314.A1073@ss1000.ms.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 25 Jul 2003 23:13:14 +0200 Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz> escribió:

> > [snip] The patch should also cleanly apply to 2.6.0-test1-bk2.
> 
> Actually, it does not, due to the cpumask_t -> unsigned long change. This one
> applies.

For me, it applies with offsets :-/

I get this
kernel/built-in.o(.text+0x414e): In function `migration_call':
: undefined reference to `cpumask_of_cpu'
make: *** [.tmp_vmlinux1] Error 1
diego@estel:~/kernel/unsta$ 

cpumask_of_cpu is not declared/used anywhere in the kernel (apart
of kernel/sched.c:2498, after applying bk2 + your patch)

