Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbRGMOSu>; Fri, 13 Jul 2001 10:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbRGMOSk>; Fri, 13 Jul 2001 10:18:40 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:4105 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S267484AbRGMOS2>; Fri, 13 Jul 2001 10:18:28 -0400
Date: Fri, 13 Jul 2001 10:17:49 -0400
From: Chris Mason <mason@suse.com>
To: Steffen Grunewald <steffen@gfz-potsdam.de>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs error message
Message-ID: <630460000.995033868@tiny>
In-Reply-To: <20010712133544.R10669@dss19>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, July 12, 2001 01:35:44 PM +0200 Steffen Grunewald
<steffen@gfz-potsdam.de> wrote:

> Should I worry about
> 
> kernel: vs-13048: reiserfs_iget: key in inode [62743 393750 0 0] and key
> 	in entry [62444 393750 0 0] do not match
> 
> ? This is SuSE 7.1 kernel 2.2.18, with automatic FTP updates.
> 

This is due to two files sharing the same inode number, which isn't supposed
to happen.  You can find the two files by doing a find -inum 393750 on the
filesystem.  You probably want to grab the latest reiserfsck from
ftp.namesys.com/pub/reiserfsprogs/pre and check the entire FS.

The only known way to trigger this problems involves running an older version
of reiserfsck --rebuild-tree.  Have you done that?

-chris

