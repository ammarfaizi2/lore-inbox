Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282801AbRK0ElH>; Mon, 26 Nov 2001 23:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282796AbRK0Ekv>; Mon, 26 Nov 2001 23:40:51 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:29195 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282801AbRK0Ekl>; Mon, 26 Nov 2001 23:40:41 -0500
Message-Id: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 26 Nov 2001 23:41:58 -0500
To: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
From: Linux maillist account <l-k@mindspring.com>
Subject: a nohup-like interface to cpu affinity
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1006832357.1385.3.camel@icbm>
In-Reply-To: <E16744i-0004zQ-00@localhost>
 <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
 <1006472754.1336.0.camel@icbm>
 <E16744i-0004zQ-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert and Ingo,
A nohup-like interface to the cpu affinity service would be useful.  It 
could work like the
following example:

    $ cpuselect -c 1,3-5 gcc -c module.c

which would restrict this instantiation of gcc and all of its children to 
cpus 1,3,4, and 5.  This
tool can be implemented in a few lines of C, with either /proc or syscall 
as the underlying
implementation.

On another subject -- capabilities -- any process should be able to reduce 
the number of
cpus in its own cpu affinity mask without any special permission.  To add 
cpus to a
reduced mask, or to change the cpu affinity mask of other processes, should 
require
the appropriate capability, be it CAP_SYS_NICE, CAP_SYS_ADMIN, or whatever
is decided.

Joe 

