Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTIRWMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbTIRWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 18:12:34 -0400
Received: from smtp2.brturbo.com ([200.199.201.158]:32930 "EHLO
	smtp2.brturbo.com") by vger.kernel.org with ESMTP id S262177AbTIRWMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 18:12:32 -0400
From: Guilherme Polo <gpolo@nl.linux.org>
Reply-To: gpolo@nl.linux.org
To: linux-xfs@oss.sgi.com
Subject: Re: PROBLEM: XFS internal error - kernel 2.4.22
Date: Thu, 18 Sep 2003 19:12:22 -0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309181912.22703.gpolo@nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 September 2003 18:57, Nathan Straz wrote:
> On Thu, Sep 18, 2003 at 06:36:57PM -0300, Guilherme Polo wrote:
> > Hello, today I was doing rm -rf on some old kernel trees on a partition
> > that uses xfs and I got this message:
> > -------------------------
> > XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1596 of file
> > xfs_alloc.c. Caller 0xc017c066
> > c3645d7c c01a63b8 00000000 00013aec cc1b9cf0 c017b383 c02c26aa 00000001
> >        00000000 c02c2684 0000063c c017c066 00000000 00013aec cc1b9cf0
> > 00000000 d6341400 00000000 caf8c0c0 d6341400 00000000 00000001 00013aeb
> > 0001fb3a Call Trace: [<c01a63b8>]  [<c017b383>]  [<c017c066>] 
> > [<c017c066>] [<c018b783>]  [<c01ae6ba>]  [<c01c683d>]  [<c01d6f97>] 
> > [<c01d5de0>] [<c0146c5b>]  [<c01474e6>]  [<c014595c>]  [<c013eadc>] 
> > [<c013eba9>] [<c0108813>]
> > xfs_force_shutdown(ide0(3,3),0x8) called from line 4051 of file
> > xfs_bmap.c. Return address = 0xc01d694a
> > Filesystem "ide0(3,3)": Corruption of in-memory data detected.  Shutting
> > down filesystem: ide0(3,3)
> > Please umount the filesystem, and rectify the problem(s)
> > -------------------------
> >
> > Im using linux 2.4.22 with xfs for i386
> > Hmm... I dont know what more to include here (first time posting a
> > problem here)
>
> That looks like a really hard bug to hit.  We'd better make sure this
> crosses the XFS list.  Do you have a good idea what you were doing at
> the time?

I was just running BitchX and deleting those old kernel trees.
After remounting the filesystem, I noticed the last kernel tree that was 
supposed to be deleted was still there, and every time I run rm -rf on that 
directory that problem above happens.

