Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUCCFD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbUCCFD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:03:56 -0500
Received: from mailbox3.ucsd.edu ([132.239.1.55]:36109 "EHLO mailbox3.ucsd.edu")
	by vger.kernel.org with ESMTP id S261609AbUCCFDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:03:54 -0500
Message-ID: <40456735.2060505@cs.ucsd.edu>
Date: Tue, 02 Mar 2004 21:03:49 -0800
From: Diwaker Gupta <dgupta@cs.ucsd.edu>
Reply-To: diwaker@ucsd.edu
Organization: CS @ UCSD
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: PASSED (v1.2.8 70089 i2353oD2089859 mailbox3.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+ Summary:
Getting repeated badness in local_bh_enable messages in syslog.

+ Description:
Here's a sample output from dmesg:
Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c01241f9>] local_bh_enable+0x89/0x90
 [<c012f985>] worker_thread+0x1c5/0x260
 [<e0995230>] xmit_bh+0x0/0xe0 [ndiswrapper]
 [<c011ccb0>] default_wake_function+0x0/0x20
 [<c010b2d2>] ret_from_fork+0x6/0x14
 [<c011ccb0>] default_wake_function+0x0/0x20
 [<c012f7c0>] worker_thread+0x0/0x260
 [<c01092a5>] kernel_thread_helper+0x5/0x10

+ Environment
Linux 2.6.3 vanilla from kernel.org
LIRC patch from <http://flameeyes.web.ctonet.it/downloads.html#lirc>

I searched the archives and got a few lines here and there talking about
PPP problems giving rise to similar messages. However, I'm not using PPP
at all, and was having no such messages till 2.6.2. There were also some
messages talking about IrDA issues, and I am using IrDA (which works fine).

If this indeed is an IrDA problem, where can I find patches to fix it.
If not, what else could be the problem?

Thanks
-- 
Diwaker Gupta
Graduate Student, Computer Sc. and Engg.
University of California, San Diego
<http://www.cs.ucsd.edu/~dgupta>
