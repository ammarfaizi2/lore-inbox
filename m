Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbTG1U2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTG1U2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:28:22 -0400
Received: from web60001.mail.yahoo.com ([216.109.116.224]:17811 "HELO
	web60001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271045AbTG1U1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:27:52 -0400
Message-ID: <20030728202750.73149.qmail@web60001.mail.yahoo.com>
Date: Mon, 28 Jul 2003 21:27:50 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: SCHED_SOFTRR patch
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I personally see your SCHED_SOFTRR as the correct solution for multimedia
applications.  But as it is currently tuned I have been unable to get it to
work adequately with a relatively undemanding program, XMMS.  I say undemanding
because XMMS only uses about 2-4% CPU time on my test machine (P3/933MHz) when
playing mp3's.

While testing SCHED_SOFTRR with XMMS I had to modify XMMS slightly since it
usually checks for uid 0 before enabling SCHED_RR.

Under 2.6.0-test1 based kernels I have experienced quite a lote of drop-outs
with XMMS playing mp3's with a moderate load, however, when run as root (with
SCHED_RR) I encountered no drop-outs at all.  When using SOFTRR under I had
very choppy playback when the machine was under load.  It was a constant
jittering more than intermittent drop-outs.

I have been using a 2.6.0-test2-O10int based kernel in my latest tests.  

With 2.6.0-test2-O10int it is very hard to get drop-outs unless I run it with
SCHED_SOFTRR!  The jitteriness is gone but a moderate load causes dropouts,
much like non SCHED_RR on 2.6.0-test1 based kernels.  SCHED_RR still runs
perfectly though.  It could be that SCHED_SOFTRR is being too "tight" with the
CPU time it is giving the Real-Time thread.

I have tried various values for the SCHED_TS_KSOFTRR, MIN_SRT_TIMESLICE,
MAX_SRT_TIMESLICE constants, but have been as yet unable to find values that
produce a good result.

The lattest.c program does show that SOFT_RR is working as does top which shows
RT priority for XMMS.


=====
Steve

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
