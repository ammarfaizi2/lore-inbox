Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVBQLks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVBQLks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 06:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVBQLks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 06:40:48 -0500
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:35539 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262069AbVBQLkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 06:40:42 -0500
Subject: Re: NTFS - Kernel memory leak in driver for kernel 2.4.28?
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Martin Bogomolni <martinbogo@gmail.com>
Cc: linux-os@analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <712fce105021609163a605f51@mail.gmail.com>
References: <712fce1050216082847bec092@mail.gmail.com>
	 <Pine.LNX.4.61.0502161151370.10018@chaos.analogic.com>
	 <712fce105021609163a605f51@mail.gmail.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Thu, 17 Feb 2005 11:40:31 +0000
Message-Id: <1108640432.7281.8.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-16 at 09:16 -0800, Martin Bogomolni wrote:
> I should say that the malloc() succeeds, but the 16mb I need for the
> buffer are not available.  Since there is no swap/page file in the
> embedded environment, there isn't enough memory left afterwards for
> the buffer.
> 
> After taking another look at the problem, the kernel has a lot of
> memory tied up in the inode and dentry cache.   I've tuned
> /proc/sys/vm/vm_cache_scan_ratio, vm_mapped_ratio, vm_vfs_scan_ratio
> with no real success in shrinking the amount of memory used by these
> caches.
> 
> Is there a way to tune and shring the overall amount of memory the
> kernel attempts to use for the dentry/inode cache, or make it much,
> much more aggressive at clearing it?

Are you using the old (1.x) or new (2.x) ntfs driver?

If you are using the old one you could try using the new driver.  That
should be a lot better than the old one in terms of how much memory it
uses.  You can get an outdated patch (but should still work) for the new
driver here:

http://sourceforge.net/project/showfiles.php?group_id=13956&package_id=21892

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

