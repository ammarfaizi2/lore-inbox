Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVCDHe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVCDHe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVCDHe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:34:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14780 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261281AbVCDHeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:34:23 -0500
Date: Fri, 4 Mar 2005 08:34:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Junfeng Yang <yjf@stanford.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiser@namesys.com,
       mc@cs.Stanford.EDU
Subject: Re: [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync
 option?
In-Reply-To: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.LNX.4.61.0503040831470.7350@yvahk01.tjqt.qr>
References: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>All warnings boil down to a single cause:  when these file systems are
>mounted -o sync or dirsync, dirty blocks are still written out
>asynchronously.  It appears to me that these mount options don't have any
>effect on these file systems.  Is this the intended behavior?

At least my HDD LED flashes regularly when I add -o sync...
(Using `mount / -o remount,sync`)

It may happen that FISC reads the disk before the write command even finished. 
With all the HD head movement optimization in the kernel (block layer, 
boiling down to TCQ/NCQ), this sounds possible.


Jan Engelhardt
-- 
