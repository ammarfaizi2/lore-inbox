Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTHSTsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHSTrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:47:13 -0400
Received: from web41411.mail.yahoo.com ([66.218.93.77]:58765 "HELO
	web41411.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261337AbTHSTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:46:45 -0400
Message-ID: <20030819194644.26776.qmail@web41411.mail.yahoo.com>
Date: Tue, 19 Aug 2003 12:46:44 -0700 (PDT)
From: Rock Gordon <rockgordon@yahoo.com>
Subject: init consumes 99% cpu, syslog Z
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using linux-2.4.18 (vanilla, from ftp.kernel.org)
on a RedHat 7.3 release. The filesystem is XFS. When
doing heavy I/O (16 processes each writing or reading
between 2 and 5 GB of data to a 2TB XFS filesystem), I
see wierd unsolvable problems -

Firstly, init all of a sudden starts consuming upwards
of 99% cpu (the profiler shows that it spends most of
it's time in the functions
send_sig_info()/force_sig_info()). Pretty soon (10-15
seconds or so), syslogd becomes a zombie, with init
still spinning in R mode.

Absolutely nothing in /var/log/messages; and dmesg
shows nothing either. No visible barfing. And this
goes on and on.

Any process I run after this keeps getting segfaults,
and also ends up becoming a zombie. This problem
repeats exactly on other identical machines.

The system is a dual-CPU 2.4Ghz Dell 2650 machine and
the problems show up without hyperthreading too. The
problem shows up without XFS too.

Any ideas/suggestions?

Thanks and Regards,
Rocky

PS: I am not on the list.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
