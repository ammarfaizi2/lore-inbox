Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUA3EXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUA3EXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:23:18 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:21205 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S266339AbUA3EXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:23:12 -0500
Date: Fri, 30 Jan 2004 17:24:25 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Software Suspend 2.0
To: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075436665.2086.3.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Software Suspend 2.0 for Linux 2.4 and 2.6 kernels is now available from
http://swsusp.sf.net. The 2.0 release is a major advance over previous
versions and includes the following features:

- Support for HighMem[1], SMP[2] and preemptive kernels.
- Support for any number of swap partitions and/or files.
- Full asynchronous I/O and readahead for synchronous I/O for maximum
throughput.
- Image compression (LZF and GZIP - the former is very fast and highly
recommended).
- Support for saving a full image of your memory, resulting in a fast,
responsive system after resuming.
- Support for plugins: data transformers (compression, encryption) and
new storage backends (NFS support is planned).
- Nice user interface (Bootsplash (http://www.bootsplash.org)
compatible;
- The ability to specify a maximum image size;
- The ability to cancel a suspend by pressing Escape (for security, this
can be disabled). 
- Speed and reliability. Software Suspend 2.0 has been extensively
tested in a variety of configurations over many months. It is not
guaranteed to be perfect, but bugs found will be hunted and fixed
quickly.
The Software Suspend website includes extensive documentation, including
known issues (primarily DRI and USB support) and FAQS. A well-used
mailing list is also available.

Known issues with Suspend 2.0 are as follows:
- DRI support is lacking power management support under 2.4 & 2.6.
- AGP support under 2.6 is partially implemented.
- USB support under 2.4 and 2.6 is lacking.
- SMP support is currently 2.4 only.
- Other drivers have varying degrees of power management support.
- There is currently no support for discontig memory.
- Suspend currently requires the PSE extension (check /proc/cpuinfo).
- Highmem >4GB is currently not supported.
- SMP currently suffers from lost interrupts during resuming
- 2.6 does not currently flush caches properly before powering down.

Some of these issues have work-arounds available: check the FAQs for
details.

Note that two patches are required to use suspend: one for the
particular kernel version you are using (make sure you get the most
recent for your kernel version), and a second (applied afterwards)
contains the core files.

Special thanks go to Gabor Kuti, Pavel Machek and Florent Chabaud for
their work, which I have built on; to Michael Frank for many months of
extensive testing of the code, to Marc Lehmann for supplying the LZF
compressor, to Bernard Blackham for maintaining the swsusp.sf.net
website and especially to LinuxFund.org for their sponsorship of the
project, which has allowed me to work full-time on Software Suspend over
the last four months.

Finally, heres a little ditty, to be sung to the tune of the 'The
Pirates Who Don't Do Anything'
(http://www.bassbios.com/bodclan/pirates.mp3) 

I'm just a user who wanted to suspend,
I didn't want to be a kernel hacker at all!
I'm just a user who wanted to suspend,
and now I'm happy because I can suspend.

Well I've never been to LinuxConf
and I've never written a device driver
And I've never talked to Linus
and I'm not an expert at BK
And I don't normally get paid to do this
and I don't own any hardware manuals
And I've never been to Boston in the fall...


[1] Up to 4GB.
[2] SMP is currently only supported under 2.4; 2.6 support should not be
far away. 
-- 
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

