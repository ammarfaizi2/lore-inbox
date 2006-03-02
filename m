Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWCBI74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWCBI74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWCBI74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:59:56 -0500
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:62093 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751975AbWCBI7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:59:55 -0500
Subject: Suspend to RAM regression retraced
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Thu, 02 Mar 2006 19:58:45 +1100
Message-Id: <1141289925.18519.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while ago I reported a regression (http://lkml.org/lkml/2005/9/21/290)
in suspend to RAM that happened with kernel 2.6.12 on my Dell D600
laptop. After several months of testing (this is my work machine and the
bug takes time to reproduce), I have finally narrowed it down. It seems
like to problem was introduced between 2.6.12-rc5 and 2.6.12-rc6. 

Basically, what happens is that with 2.6.12-rc6, my machine *sometimes*
doesn't resume when I suspend it. This happens especially when it has
been running for a while. It almost always works when I just rebooted,
or if I just successfully resumed. So it behaves like "something" gets
randomly corrupted, at which point the machine still works, but will not
resume if I suspend it. Also, I've observed the same behaviour with and
without preemption enabled. 

Can someone have a look at what could cause the problem and fix it? I
can provide more information if needed. BTW, I'm not on the list so
please CC to me.

Thanks,

	Jean-Marc

P.S. Machine setup is:
Ubuntu 5.10 (but problem also observed on 5.04 and old Debian unstable)
Dell Latitude D600 (Bios rev. A14)
Pentium-M 1.6 GHz / 1 GB RAM
ATI Technologies, Inc. Radeon Mobility 9000 M9 (R250 Lf)

