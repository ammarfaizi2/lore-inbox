Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVCLMLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVCLMLi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 07:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVCLMLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 07:11:38 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:18386 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261695AbVCLMLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 07:11:32 -0500
Date: Sat, 12 Mar 2005 04:11:14 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-hfsplus-devel@lists.sourceforge.net
cc: mc@cs.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CHECKER] sync, fsync and mount -o sync all not flush things out
 properly (hfsplus, 2.6.11)
Message-ID: <Pine.GSO.4.44.0503120401290.12531-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We developed a file system checker called FiSC and recently applied it to
hfsplus.  It complains 3 things about hfsplus:

1. sync on hfsplus doesn't actually flush everything out.  Immediate crash
after sync still causes data-loss  (testcase:
http://fisc.stanford.edu/bug13/crash.c)

2. fsync on hfsplus doesn't actually flush out the file.
(http://fisc.stanford.edu/bug14/crash.c)

3. mount -o sync doesn't cause file system operations to be synchronous.
(http://fisc.stanford.edu/bug15/crash.c)

To reproduce these warnings, download the test case and run it.  You might
need to customize the test case according to your local settings.  Let me
know if you need any more information to reproduce the warnings.

Any confirmations/clarifications are appreciated.
-Junfeng

