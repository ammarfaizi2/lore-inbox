Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVIJNiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVIJNiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVIJNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:38:07 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:21220 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750836AbVIJNiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:38:06 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 10 Sep 2005 14:38:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24.
In-Reply-To: <Pine.LNX.4.60.0509101424260.20200@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509101437330.20200@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
 <58obd5djrqk$.1nrux2jfwk0jg.dlg@40tude.net> <Pine.LNX.4.60.0509101424260.20200@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Anton Altaparmakov wrote:
> On Sat, 10 Sep 2005, Giuseppe Bilotta wrote:
> > On Fri, 9 Sep 2005 10:18:01 +0100 (BST), Anton Altaparmakov wrote:
> > > This is the next NTFS update containing a ton of bug fixes several of 
> > > which fix bugs people actually hit in the big bad world...
> > > 
> > > Please apply.  Thanks!
> > > 
> > > I am sending the changesets as actual patches generated using git 
> > > format-patch for non-git users in follow up emails (in reply to this one).
> > 
> > BTW Anton, while looking for the best permission masks to be used when
> > mounting my NTFS paritions, I spotted what I think is a bug, or at
> > least an inconsistency between the way all fs drivers I use handle
> > umasks & friends, and the way NTFS does it. Basically, all the other
> > fs drivers take an octal representation of the masks. NTFS, instead,
> > seems to use _decimal_
> 
> NTFS takes any.  It is happy with octal, decimal, and hex.  The ntfs 
> driver uses linux/lib/vsprintf.c::simple_strtoul() with a zero base which 
> autodetects which base to use so if you use umask=0222 it will take this 
> as octal and if you use umask=222 it will take this as decimal and if you 
> use 0x222 it will take this as decimal.
                                 ^^^^^^^ hexadecimal

> I do not see what is wrong with that.  It behaves exactly like I would 
> expect it to.  Maybe I have strange expectations?  (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
