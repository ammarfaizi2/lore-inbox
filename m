Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUEDUDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUEDUDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEDUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:03:36 -0400
Received: from smtp.wp.pl ([212.77.101.160]:16533 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264500AbUEDUD0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:03:26 -0400
Date: Tue, 4 May 2004 22:03:25 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27-pre2 (gcc-3.4.0)
Message-Id: <20040504220325.25516d8f.rmrmg@wp.pl>
In-Reply-To: <200405042146.40404@WOLK>
References: <20040503230911.GE7068@logos.cnet>
	<20040504211939.79ed1e6f.rmrmg@wp.pl>
	<200405042146.40404@WOLK>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com> quote:

> On Tuesday 04 May 2004 21:19, Rafa³ 'rmrmg' Roszak wrote:
> 
> Hi Rafa³
> 
> > make[2]: Entering directory `/usr/src/linux-2.4.27-pre2/kernel'
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-pre2/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
> > -march=athlon-nostdinc -iwithprefix include -DKBUILD_BASENAME=sched
> > -fno-omit-frame-pointer -c -o sched.o sched.c sched.c:213: error:
> > conflicting types for 'reschedule_idle' sched.c:210: error: previous
> > declaration of 'reschedule_idle' was here sched.c:213: error:
> > conflicting types for 'reschedule_idle' sched.c:210: error: previous
> > declaration of 'reschedule_idle' was here sched.c:371: error:
> > This problem exist when i use GCC-3.4.0, GCC-3.2.3 doesn't cause it.
> 
> Does the attached patch help there?
> 

Nope

make[2]: Entering directory `/usr/src/linux-2.4.27-pre2/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27-pre2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=sched 
-fno-omit-frame-pointer -c -o sched.o sched.c sched.c:369: error:
conflicting types for
'wake_up_process'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:603:
error: previous declaration of 'wake_up_process' was here sched.c:369:
error: conflicting types for
'wake_up_process'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:603:
error: previous declaration of 'wake_up_process' was here sched.c:407:
error: conflicting types for
'schedule_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:148:
error: previous declaration of 'schedule_timeout' was here sched.c:407:
error: conflicting types for
'schedule_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:148:
error: previous declaration of 'schedule_timeout' was here sched.c:737:
error: conflicting types for
'__wake_up'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:595: error:
previous declaration of '__wake_up' was here sched.c:737: error:
conflicting types for
'__wake_up'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:595: error:
previous declaration of '__wake_up' was here sched.c:747: error:
conflicting types for
'__wake_up_sync'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:596:
error: previous declaration of '__wake_up_sync' was here sched.c:747:
error: conflicting types for
'__wake_up_sync'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:596:
error: previous declaration of '__wake_up_sync' was here sched.c:757:
error: conflicting types for
'complete'/usr/src/linux-2.4.27-pre2/include/linux/completion.h:31:
error: previous declaration of 'complete' was here sched.c:757: error:
conflicting types for
'complete'/usr/src/linux-2.4.27-pre2/include/linux/completion.h:31:
error: previous declaration of 'complete' was here sched.c:767: error:
conflicting types for
'wait_for_completion'/usr/src/linux-2.4.27-pre2/include/linux/completio
n.h:30: error: previous declaration of 'wait_for_completion' was here
sched.c:767: error: conflicting types for
'wait_for_completion'/usr/src/linux-2.4.27-pre2/include/linux/completio
n.h:30: error: previous declaration of 'wait_for_completion' was here
sched.c:802: error: conflicting types for
'interruptible_sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.
h:600: error: previous declaration of 'interruptible_sleep_on' was here
sched.c:802: error: conflicting types for
'interruptible_sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.
h:600: error: previous declaration of 'interruptible_sleep_on' was here
sched.c:813: error: conflicting types for
'interruptible_sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linu
x/sched.h:601: error: previous declaration of
'interruptible_sleep_on_timeout' was here sched.c:813: error:
conflicting types for
'interruptible_sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linu
x/sched.h:601: error: previous declaration of
'interruptible_sleep_on_timeout' was here sched.c:826: error:
conflicting types for
'sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:597: error:
previous declaration of 'sleep_on' was here sched.c:826: error:
conflicting types for
'sleep_on'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:597: error:
previous declaration of 'sleep_on' was here sched.c:837: error:
conflicting types for
'sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:598:
error: previous declaration of 'sleep_on_timeout' was here sched.c:837:
error: conflicting types for
'sleep_on_timeout'/usr/src/linux-2.4.27-pre2/include/linux/sched.h:598:
error: previous declaration of 'sleep_on_timeout' was here make[2]: ***
[sched.o] Error 1 make[2]: Leaving directory
`/usr/src/linux-2.4.27-pre2/kernel' make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.27-pre2/kernel'
make: *** [_dir_kernel] Error 2

-- 
. JID: rmrmg(at)jabberpl(dot)org |   RMRMG   .
.           gg: #2311504         | signature .
.   mail: rmrmg(at)wp(dot)pl     |  version  .
.  registered Linux user 261525  |   0.0.3   .
