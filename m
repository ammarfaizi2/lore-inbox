Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUBHLit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUBHLit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:38:49 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:6341 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S263466AbUBHLir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:38:47 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Valdis.Kletnieks@vt.edu
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers 
In-reply-to: Your message of "Mon, 19 Jan 2004 11:20:51 CDT."
             <200401191620.i0JGKqKe012285@turing-police.cc.vt.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Feb 2004 22:38:06 +1100
Message-ID: <31255.1076240286@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 11:20:51 -0500, 
Valdis.Kletnieks@vt.edu wrote:
>I don't know how IBM did disk space management on the earlier systems
>such as the 1401, 7040, and 7090 series, but I'd suspect it was a similar
>extent-based method.

<old-fogey-mode>

Can't speak for the 1401 or 7xxx series.  IBM 1620[*], which was
obsolete back in 1977 when I programmed it, also used extent based disk
directories.  There were three directory areas on disk, one to map file
names to extent indexes, one to map the used extents on the disk and
one to map the free space extents.

[*] Binary coded decimal.  Each digit had 4 numeric bits plus two flag
    bits.  Two adjacent digits made a letter (and you thought that
    Unicode was bad!).  Card punch or paper tape in/out.  No printer,
    feed the cards through a separate machine for that.  20,000 digits
    of memory with a 2 Mb disk drive was a big machine.

    Five digit addressing with one nice feature, if the flag bit was
    set on the rightmost digit of an address then it was automatically
    treated as an indirect address and the real address was fetched
    from the area referenced by this address, the real address could
    also be flagged as indirect and the process would continue.  The
    IBM manual claimed that indirect addresses required no extra time
    (nothing changes about computer claims :).  The student's idea of
    fun was to load all of memory with indirect addresses, each
    pointing to the next with loop around.  Refer to the first and
    watch the big panel lights slowly cycle through all of memory doing
    nothing useful.

</old-fogey-mode>

