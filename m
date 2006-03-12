Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWCLRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWCLRLt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWCLRLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:11:48 -0500
Received: from webbox444.server-home.org ([83.220.144.13]:53951 "EHLO
	webbox444.server-home.org") by vger.kernel.org with ESMTP
	id S1751607AbWCLRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:11:48 -0500
Subject: [ANNOUNCE][RFC] dynsched-0.1.1 for  2.6.13
From: Christian Ege <christian.ege@cybertux.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Chris Han <xiphux@gmail.com>,
       Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>,
       Michael =?ISO-8859-1?Q?M=E4chtel?= <" maechtel"@fh-konstanz.de>,
       Dyn-Scheduler Mailingliste <dyn-scheduler@cybertux.org>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 18:11:41 +0100
Message-Id: <1142183502.8725.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there is a new version of dynsched released. It includes some minor
bugfixes and code cleanups. we are looking forward to your suggestions
and we are highly interested in a discussion.


In the next step we will port the patch to the current plugsched version
and split the patch in a plugsched part and a dynsched part.


The "dynsched" project aims switching the CPU scheduler at runtime. Its
based upon the "plugsched" patch by Peter Williams
(http://cpuse.sourceforge.net/). Increments to plugsched especially
a kthread, wich switchs between different schedulers, in sched.c and a
proc user interface. 

Following scheduler implementations are currently supported:
* ingosched
* nicksched
* staircase

There are some missing functions like converting task_struct between the
schedulers. First tests on kernel 2.6.13.5 and 2.6.13.4
were successful. The spa based schedulers (such as spa_no_frills, zaphod
etc) are not yet supported. I hope they will be finished soon, just as
SMP support.

There is an alpha patch available at project site -
https://sourceforge.net/projects/dynsched


Using the procfs you can switch between the linux standard scheduler
(ingosched), nicksched and staircase schedulers by simply issuing: 
echo "name_of_the_scheduler" > /proc/dynsched


There have been successful tests to switch the cpu scheduler while
running a fully loaded Linux system, running a KDE Desktop with a lot of
applications.

Christian Ege


-- 
------------------------------------------------------------------
 
 Name:   Christian Ege
 mailto: christian.ege@cybertux.org
  
 BLOG:   http://chris.cybertux.org
 WWW:    http://www.cybertux.org
  
 PGP Key fingerprint:
 E436 3E5D CE47 7D0E DB63  F383 B41A 5FCF D4A1 D7A0
 Informationen zu PGP: ( http://www.gnupg.de/ )
==================================================================

