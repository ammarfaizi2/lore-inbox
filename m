Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUJZHoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUJZHoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUJZHnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:43:03 -0400
Received: from siaag2aa.compuserve.com ([149.174.40.131]:59860 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262175AbUJZHlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:41:02 -0400
Date: Tue, 26 Oct 2004 03:38:06 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BK kernel workflow
To: Larry McVoy <lm@bitmover.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410260340_MC3-1-8D30-9CCE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> we're working bug database integration, we're working
> on review queues, we're working on project management, we're working on
> large binary management, etc.

  How about support for backporting patches, e.g. backport csets
1.2000.4.120 and 1.2000.12.16 to kernel 2.6.9?  I could see no way to get
bk to spit out these two changes as patches against 2.6.9.  Given all the info
in there this should be trivial...

  But first you should write some actual documentation and fix your programs
so they emit error messages when something goes wrong:

[me@d4 linux-2.6]$ bk c2r -r@v2.6.9 mm/vmscan.c
[me@d4 linux-2.6]$                                               <--- what???
[me@d4 linux-2.6]$ bk tags
<snip>
ChangeSet@1.1988.97.17, 2004-10-18 11:50:06-07:00, torvalds@ppc970.osdl.org
  Linux 2.6.9
  TAG: v2.6.9
<snip>
[me@d4 linux-2.6]$ bk c2r -r1.1988.97.17 mm/vmscan.c
1.231

  'bk help terms' says a tag can be used, but apparently not and there's
no error message.

  Then there's this one:

[me@d4 linux-2.6]$ bk difftool -rv2.6.8 -rv2.6.9 mm/vmscan.c     <--- forgot the @
child process exited abnormally                                  <--- hee hee!

  I like the way the GUI flashes up on the screen then abruptly disappears, leaving
the user wondering what happened.


> The list goes on, if anyone wants to come work on it we are always looking
> for good systems people and we pay well.

  But you're located in a large American metro area, a.k.a. "hell on earth."


--Chuck Ebbert  26-Oct-04  03:19:25
