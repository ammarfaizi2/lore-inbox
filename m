Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVASAWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVASAWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVASAWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:22:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:10983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261504AbVASATu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:19:50 -0500
Date: Tue, 18 Jan 2005 16:19:46 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <stp-devel@lists.sourceforge.net>,
       <ltp-list@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <hanrahat@osdl.org>
Subject: LTP Results for 2.6.x and 2.4.x
In-Reply-To: <Pine.LNX.4.58.0410011536060.2403@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.33.0501181540480.11396-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated summary of our LTP regression test runs against the
2.6.x and 2.4.x kernels on RedHat 9.0:

    http://developer.osdl.org/bryce/ltp/


Briefly, here are the numbers for the most recent kernels:

Patch Name           TestReq#   LTP Ver   CPU    PASS  FAIL  WARN  BROK
-----------------------------------------------------------------------
linux-2.6.10           299759   20041105  2-way  2196     6     2     6
patch-2.6.10-rc3       299166   20041007  2-way  2199     6     2     6
patch-2.6.10-rc2       298746   20041007  2-way  2198     8     2     6
patch-2.6.10-rc1       298400   20041007  2-way  2198     6     2     6


Patch Name           TestReq#   LTP       CPU    PASS  FAIL  WARN  BROK
-----------------------------------------------------------------------
patch-2.4.29-rc3       300054   20041105  2-way  2210     3     2     3
patch-2.4.29-rc1       299873   20041105  2-way  2210     3     2     3
patch-2.4.29-pre2      299601   20041105  2-way  2210     3     2     3
patch-2.4.29-pre1      298976   20041007  2-way  2210     3     2     3
linux-2.4.28           298851   20041007  2-way  2210     3     2     3


A summary and a detailed report of the current failures on 2.6.10 is
available at:

   http://khack.osdl.org/299759/results/FAIL_summary.txt
   http://developer.osdl.org/bryce/ltp/failrpt_299759_2.6.10.txt

I've run into some issues with patch-2.6.11-rc1 and the latest LTP, but
will post numbers when I've sorted those out.

Bryce

On Fri, 1 Oct 2004, Linus Torvalds wrote:
> On Fri, 1 Oct 2004, Bryce Harrington wrote:
> >
> >  madvise02     7   FAIL : madvise failed with wrong errno, expected
> >                           errno = 22, got errno = 12 : Cannot allocate
> >                           memory
> >                    See: ltp/testcases/kernel/syscalls/madvise/madvise02.c
>
> Are you running this test on a 64-bit kernel with a 32-bit test
> environment? This failure _looks_ that way, apparently because the
> compatibility layer doesn't sign-extend "len". And quite frankly,
> sign-extending it would be silly, although I think it would make the test
> happy.
>
> 		Linus
>


