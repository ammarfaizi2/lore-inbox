Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSIZWN3>; Thu, 26 Sep 2002 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261534AbSIZWN3>; Thu, 26 Sep 2002 18:13:29 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:30635 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261529AbSIZWNW>; Thu, 26 Sep 2002 18:13:22 -0400
Subject: Hard lockups running X with 2.5.38-bk4, -bk5 and -mm3
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Sep 2002 16:14:34 -0600
Message-Id: <1033078474.1306.43.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I only recently started testing 2.5.x kernels with X, and have
immediately run into problems.

My new test system is a Dell GX110 single PIII, IDE (Intel 82801AA IDE),
256MB memory.  The 2.5.38-bk4,5 and -mm3 kernels were SMP (due to
not having Rusty's cpu_possible fix), non-PREEMPT.  

Running XFree86 4.2.1, I get a hard lockup with the box not responsive
to pings.  Ssh sessions don't respond and the pointer does not respond
to mouse movements.  This occurs very soon (2-3 minutes) after starting
X with 2.5.38-bk4 and -bk5.  I was able to run 2.5.38-mm3 for about 30
minutes under load (kernel compiles) before a freeze occurred.  I ran
2.5.38-mm3 again for about 20 minutes with X and under load before a
second lockup occurred.  Sorry, nothing logged, and when the freezes
occur, there is no response to SYSRQ-H,S or B.  SYSRQ-H works as
expected before the freeze.

Without running X on this system, no freezes have been observed with any
of these kernels with the system loaded by running kernel compiles and
dbench with up to 40 clients.

The kernel compiles and dbench load tests were done on an ext3 /home
partition. /, /usr, /var are all ext3 also.

Steven




