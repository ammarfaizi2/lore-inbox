Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965289AbVIPALt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbVIPALt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbVIPALt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:11:49 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:57057 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965289AbVIPALs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:11:48 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 16 Sep 2005 01:11:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Bas Vermeulen <bvermeul@blackstar.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
In-Reply-To: <1126822443.4776.3.camel@laptop.blackstar.nl>
Message-ID: <Pine.LNX.4.60.0509160111150.3678@hermes-1.csi.cam.ac.uk>
References: <1126769362.5358.3.camel@laptop.blackstar.nl> 
 <Pine.LNX.4.60.0509150954290.29921@hermes-1.csi.cam.ac.uk> 
 <1126812296.4776.2.camel@laptop.blackstar.nl> 
 <Pine.LNX.4.60.0509152219260.21782@hermes-1.csi.cam.ac.uk>
 <1126822443.4776.3.camel@laptop.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Bas Vermeulen wrote:
> On Thu, 2005-09-15 at 22:21 +0100, Anton Altaparmakov wrote:
> > On Thu, 15 Sep 2005, Bas Vermeulen wrote:
> > > Sep 15 21:13:43 laptop kernel: [4295071.339000] NTFS volume version 3.1.
> > > Sep 15 21:13:43 laptop kernel: [4295071.339000] NTFS-fs error (device
> > > sda2): load_system_files(): Volume is dirty.  Mounting read-only.  Run
> > > chkdsk and mount in Windows.
> > > Sep 15 21:13:43 laptop kernel: [4295071.439000] NTFS-fs error (device
> > > sda2): ntfs_readpage(): Eeek!  i_ino = 0x5, type = 0xa0, name_len = 0x4.
> > 
> > Great, thanks!  I suspected this might be the case but I didn't think 
> > that was possible.  )-:
> > 
> > Could you confirm for me that this ntfs volume is compressed?  (I.e. the 
> > compression bit is enabled on the root directory.)
> 
> Yes, it is compressed.

Excellent, thanks.  I will try and do the fix tomorrow and send it to 
Linus.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
