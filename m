Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUHAXhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUHAXhi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUHAXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 19:37:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18085 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266198AbUHAXh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 19:37:26 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
In-Reply-To: <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe>  <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <1091234100.1677.41.camel@mindpipe>
	 <Pine.LNX.4.58.0408010725030.23711@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091403477.862.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 19:37:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 07:28, Ingo Molnar wrote:
> could you try to repeat the '50 usecs' test with -L2 [that was the one you
> used?] to make sure it's repeatable?

Results with L2, soundcard + RTC interrupts 'direct', N=1,000,000:

Delay   Count
-----   -----
6       24330
7       429668
8       34474
9       26184
10      12210
11      9060
12      9104
13      8460
14      11011
15      13615
16      14584
17      13371
18      12169
19      10864
20      11936
21      7974
22      6256
23      4888
24      2385
25      640
26      164
27      113
28      86
29      105
30      90
31      86
32      103
33      140
34      149
35      183
36      160
37      141
38      147
39      146
40      172
41      140
42      131
43      89
44      54
45      10
46      3
47      2
49      3

It's as I expected - same as M5, minus the outliers.  Any idea what
caused these?  I will try O2 next, I would expect it to be similar.

Lee


