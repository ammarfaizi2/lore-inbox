Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262459AbTCIHWa>; Sun, 9 Mar 2003 02:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbTCIHWa>; Sun, 9 Mar 2003 02:22:30 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:37644 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S262459AbTCIHWR>; Sun, 9 Mar 2003 02:22:17 -0500
Message-ID: <3E6AEDA5.D4C0FC83@compuserve.com>
Date: Sun, 09 Mar 2003 02:30:45 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.19-64GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Runaway cron task on 2.5.63/4 bk?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second attempt to send this after not seeing it post after about a day. 
Anyone else have kernel posting problems?

I started seeing the cron task runaway, using 100% CPU continuously on a
single CPU with
2.5.63+bk and now with 2.5.64 (about two weeks now.)  No other
apps/tasks seem to be affected, that I've noticed.  It seems to take
upwards of 8 hours running the kernel for this to occur.

top shows:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  594 root      25   0  1428  620  1364 R    49.9  0.1 195:23 cron

(This is a dual processor Athlon, so CPU0 is at 100% at the moment.) 
This is repeatable.  Leaving the box running overnight, or all day, and
the cron process is running 100% again after several hours.  This does
not occur in prior 2.5 kernels, or in 2.4.19.

Any idea what's causing this?  What additional info on the process would
be helpful?  kernel .config file at
http://kevb.net/files/linux2564_config

-- 
Kevin
