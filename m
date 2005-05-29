Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVE2SiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVE2SiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVE2SiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:38:04 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:46993 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S261391AbVE2SiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:38:01 -0400
Date: Sun, 29 May 2005 20:37:50 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS lstat() _very_ slow on SMP
Message-ID: <20050529183750.GA5274@fi.muni.cz>
References: <20050516162506.GB19415@fi.muni.cz> <20050518140258.GA22587@infradead.org> <20050518174530.GF19173@fi.muni.cz> <20050528091123.GA19330@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528091123.GA19330@infradead.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
: > ("time ./bigtree.pl /new-volume 3 128" for 128*128*128 files), and then
: > "strace -c find /new-volume -type f -mtime +1000 -print" (the numbers
: > without strace are almost the same, so strace is not a problem here).
: 
: I couldn't reproduce the odd case here.  Could you try to get some profiling
: data with oprofile for the odd and one of the normal cases?

	I have solved this by adding "ihashsize=65537" to /etc/fstab.
Now my find(1) is limited by the disk speed instead of system time.

-Y.
-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
-- Yes. CVS is much denser.                                               --
-- CVS is also total crap. So your point is?             --Linus Torvalds --
