Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUDDW77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUDDW77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 18:59:59 -0400
Received: from starsphere.linkinnovations.com ([203.94.138.50]:4224 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262907AbUDDW7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 18:59:55 -0400
Date: Mon, 5 Apr 2004 08:59:51 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5: kernel crash on large disk writes
Message-ID: <20040404225951.GA1586@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Had to leave the house quickly today so this is not as complete as I
would like. The situation is as follows: I have a k6-500 on an ali1541
(from memory) ide chipset. All channels filled with 3 hds and 1 cdrom.
2 hds on the asme port at ata66, one at ata33 and the cdrom at whatever
it's on. ;) The system boots up normally and light use is just fine. 
When I backup my laptop to it though I can repeatedly bring the system
down. The end result is an oops on the screen in soft_irq_timer that
came from cpu_idle. (I had no time to write it down). The following,
just before the oops was logged:

Apr  5 01:14:35 nessie kernel: Assertion failure in journal_add_journal_head() a
t fs/jbd/journal.c:1679: "(((&bh->b_count)->counter) > 0) || (bh->b_page && bh->
b_page->mapping)"
Apr  5 01:14:35 nessie kernel: ------------[ cut here ]------------
Apr  5 01:14:35 nessie kernel: kernel BUG at fs/jbd/journal.c:1679!

The backup was an rsync over the net.

There have been other problems with the system. It liked my promise
card in it even less (old driver variety) but nothing ever did get
logged.

If you need mroe info, please yell and I'll try to answer from memory
and I'll try to give oops details when I get home (please specify what
details you're most interested in so that I don't have to type it all
in if possible :).

Thanks.

-- 
    Red herrings strewn hither and yon.
