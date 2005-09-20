Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbVITRrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbVITRrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbVITRrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:47:39 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:17580 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932785AbVITRri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:47:38 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 20 Sep 2005 18:47:32 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Luca <kronos@kronoz.cjb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
In-Reply-To: <20050920174428.GA16327@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.60.0509201847180.29023@hermes-1.csi.cam.ac.uk>
References: <20050920174428.GA16327@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Luca wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> ha scritto:
> > On Sat, 2005-09-17 at 16:51 +0200, Luca wrote:
> >> Jean Delvare <khali@linux-fr.org> ha scritto:
> >> > Hi Anton, Bas, all,
> >> > 
> >> > [Bas Vermeulen]
> >> >> > I get a kernel BUG when mounting my (dirty) NTFS volume.
> >> >> > 
> >> >> > Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version
> >> >> > 3.1. Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error
> >> >> > (device sda2): load_system_files(): Volume is dirty.  Mounting
> >> >> > read-only.  Run chkdsk and mount in Windows.
> >> >> > Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
> >> >> > here ]------------
> >> >> > Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
> >> >> > fs/ntfs/aops.c:403!
> >> >
> >> > I just hit the same BUG in different conditions. My NTFS volume is not
> >> > dirty, not compressed and the BUG triggered on use (updatedb), not
> >> > mount.
> >> 
> >> Same here, but it only triggers accessing a compressed directory. I can
> >> reproduce at will just by using 'ls' inside a compressed dir.
> > 
> > Below is the fix I just sent off to Linus.
> 
> Hi Anton,
> I can confirm that the patch fixes the bug.

Cool, thanks.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
