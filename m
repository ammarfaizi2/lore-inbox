Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVCDICV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVCDICV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVCDICU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:02:20 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:36266 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262610AbVCDICF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:02:05 -0500
Date: Fri, 4 Mar 2005 00:01:42 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <reiser@namesys.com>,
       <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync
 option?
In-Reply-To: <Pine.LNX.4.61.0503040831470.7350@yvahk01.tjqt.qr>
Message-ID: <Pine.GSO.4.44.0503032352410.8740-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It may happen that FISC reads the disk before the write command even finished.
> With all the HD head movement optimization in the kernel (block layer,
> boiling down to TCQ/NCQ), this sounds possible.

FiSC "crashes" the kernel immediately after a file system operation
(creat, mkdir, write, etc) returns.  Presumably, if a file system is
mounted -o sync, all the FS operations should be done synchronously. i.e.,
if creat("foo") returns, the file "foo" better be on disk.  It turns out
not the case for ext2, jfs and reiserfs.

-Junfeng

