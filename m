Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUHEOm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUHEOm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHEOm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:42:29 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:23759 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S267751AbUHEOcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:32:14 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.0/5.0):. Processed in 3.312327 secs)
Date: Thu, 5 Aug 2004 16:32:04 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1831126609.20040805163204@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: Scheduler policies for staircase
In-Reply-To: <1091657248.19988.19.camel@localhost>
References: <34840234.20040804074326@dns.toxicfilms.tv>
 <cone.1091601947.196990.9775.502@pc.kolivas.org>
 <1091657248.19988.19.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Con,
>> > 
>> > I have been using SCHED_BATCH on two machines now with expected
>> > results. So this you might consider this as another success report :-)
>> 
>> Great. Thanks for the report. I too use them all day every day on each
>> machine I have with distributed computing clients so they're pretty well
>> tested.
I forgot to mention about something.

I totally deadlocked my machine just after setting the
/proc/sys/kernel/compute to 1 with
# echo 1 > /proc/sys/kernel/computer


The machine is 2x1G p3, and the kernel was SMP and I had experimentally
seti@home running in SCHED_BATCH mode in screen.

It was 2.6.8-rc1 with ck patches from:
http://ck.kolivas.org/patches/2.6/2.6.7/2.6.8-rc1/

I used these patches on 2.6.8-rc1 from it (of course in the proper
order:
__cleanup_transaction-latency-fix.patch
crq-fixes.diff
defaultcfq.diff
filemap_sync-latency-fix.patch
from_2.6.8-rc1_to_staircase7.A
get_user_pages-latency-fix.patch
jbd-recovery-latency-fix.patch
journal_clean_checkpoint_list-latency-fix.patch
kjournald-smp-latency-fix.patch
prune_dcache-latency-fix.patch
schedbatch2.3.diff
schediso2.3.diff
schedrange.diff
slab-latency-fix.patch
truncate_inode_pages-latency-fix
unmap_vmas-smp-latency-fix.patch

I haven't tried doing that again, because it is an important machine.
Just playing around with SCHED_BATCH again and reporting it.
I think I'll try to experiment on some other machine with that soon.

Regards,
Maciej



