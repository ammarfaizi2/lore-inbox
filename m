Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUJYJYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUJYJYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUJYJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:24:47 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:48823 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261727AbUJYJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:24:45 -0400
Subject: Re: [PATCH] NTFS: missing #include <linux/vmalloc.h>
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410241200550.12609@anakin>
References: <Pine.LNX.4.61.0410241200550.12609@anakin>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1098696246.16688.7.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 25 Oct 2004 10:24:06 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2004-10-24 at 11:08, Geert Uytterhoeven wrote:
> fs/ntfs/compress.c calls v{malloc,free}() without including <linux/vmalloc.h>
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> --- linux-2.6.10-rc1/fs/ntfs/compress.c.orig	2004-10-23 10:33:30.000000000 +0200
> +++ linux-2.6.10-rc1/fs/ntfs/compress.c	2004-10-24 11:58:41.000000000 +0200
> @@ -24,6 +24,7 @@
>  #include <linux/fs.h>
>  #include <linux/buffer_head.h>
>  #include <linux/blkdev.h>
> +#include <linux/vmalloc.h>
>  
>  #include "attrib.h"
>  #include "inode.h"

Thanks!  I see Linus already applied it so I don't need to do anything
about it.  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

