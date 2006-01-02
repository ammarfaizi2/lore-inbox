Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWABQqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWABQqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWABQqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:46:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34823 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750831AbWABQqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:46:37 -0500
Date: Mon, 2 Jan 2006 17:46:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Kirill Korotaev <dev@sw.ru>, Ismail Donmez <ismail@uludag.org.tr>,
       Michael Madore <michael.madore@gmail.com>,
       David Brownell <david-b@pacbell.net>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Mathias Klein <ma_klein@gmx.de>,
       Christian Casteyde <casteyde.christian@free.fr>,
       "P. Christeas" <p_christ@hol.gr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Torsten Seeboth <Torsten.Seeboth@t-online.de>, pj@sgi.com,
       simon.derr@bull.net, jt@hpl.hp.com, netdev@vger.kernel.org,
       Andrey Borzenkov <arvidjaar@mail.ru>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: 2.6.15-rc7: known regressions
Message-ID: <20060102164636.GH17398@stusta.de>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.15-rc7 compared to 2.6.14.

If you find your name in the Cc header, you are either submitter of one 
of the bugs, maintainer of an affectected subsystem or driver, a patch 
of you was declared guilty for a breakage or in any other way involved 
with one or more of these issues.


Subject    : cpuset_excl_nodes_overlap() may sleep under tasklist_lock
References : http://lkml.org/lkml/2005/12/28/63
Submitter  : Kirill Korotaev <dev@sw.ru>
Status     : unknown

Subject    : /sys/class/net/<device name>/wireless directory is gone
References : http://bugzilla.kernel.org/show_bug.cgi?id=5800
             http://marc.theaimsgroup.com/?l=linux-netdev&m=113619905529636&w=2
Submitter  : Ismail Donmez <ismail@uludag.org.tr>
Handled-By : Andrey Borzenkov <arvidjaar@mail.ru>
Status     : patch available

Subject    : USB handoff, irq 193: nobody cared!
References : http://lkml.org/lkml/2005/11/14/274
Submitter  : Michael Madore <michael.madore@gmail.com>
Status     : unknown, caused by a patch by David Brownell

Subject    : BUG: spinlock recursion on 2.6.14-mm2 when oprofiling
References : http://lkml.org/lkml/2005/11/18/95
Submitter  : Wu Fengguang <wfg@mail.ustc.edu.cn>
Handled-By : "Paul E. McKenney" <paulmck@us.ibm.com>
Status     : unknown, reported against -mm, already fixed in -mm
             (make-rcu-task_struct-safe-for-oprofile.patch)
             Is this bug present in Linus' tree?

Subject    : oops in kernel 2.6.15-rc{6,7}
References : http://lkml.org/lkml/2005/12/28/75
             http://lkml.org/lkml/2005/12/30/119
Submitter  : Mathias Klein <ma_klein@gmx.de>
Status     : unknown

Subject    : No sound with snd_intel8x0 & ALi M5455 chipset
             (kobject_register failed)
References : http://bugzilla.kernel.org/show_bug.cgi?id=5760
Submitter  : Christian Casteyde <casteyde.christian@free.fr>
Status     : submitter was asked to do a binary search for
             the guilty patch

Subject    : No sound from CX23880 tuner w. 2.6.15-rc5
References : http://lkml.org/lkml/2005/12/12/190
             http://www.spinics.net/lists/vfl/msg22791.html
Submitter  : "P. Christeas" <p_christ@hol.gr>
Handled-By : Mauro Carvalho Chehab <mchehab@infradead.org>
             Torsten Seeboth <Torsten.Seeboth@t-online.de>
Status     : regression in cx88-tvaudio.c, no patch known

Subject    : x86_64: PANIC: early exception
References : http://bugzilla.kernel.org/show_bug.cgi?id=5758
Status     : Andi considers his patch too risky for 2.6.15,
             workaround available, should be noted in the
             final 2.6.15 announcement


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

