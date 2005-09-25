Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVIYTMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVIYTMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 15:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVIYTMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 15:12:13 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:27149 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S932269AbVIYTMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 15:12:13 -0400
Date: Sun, 25 Sep 2005 21:12:05 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: Linux NTFS Vista compatibility (was: Re: [2.6-GIT] NTFS: Release
 2.1.24.)
In-Reply-To: <Pine.LNX.4.60.0509101421460.20200@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0509252047090.21817-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Sep 2005, Anton Altaparmakov wrote:
> On Sat, 10 Sep 2005, Alistair John Strachan wrote:
> >
> > Do these changes allow us to mount an NTFS volume created by Windows 
> > Vista/Longhorn beta 1 yet? 

So far the current NTFS code worked fine with Longhorn/Vista releases.
WinFS and TxFS (transactional NTFS) are on top of current NTFS and MS
engineers claim that they work hard to avoid on-disk NTFS format changes.

> > I tried the driver in 2.6.13, and it complains about these
> > $LogFile states, and ntfscp refuses to work. 

This happens probably due to the recent, strict $LogFile check changes.
Several people reported these and Anton is investigating it. 

> > If you're unaware of the problem, I'm happy to help debug it.

Anybody [keep] confirming that the current Linux NTFS code still works 
on the latest Vista beta releases would be highly encouraging for all 
of us ;)
 
> I am indeed unaware of the problem.  Could you try the latest kernel
> with the ntfs patches in it (Linus already merged them in the official
> git tree) and tell me if it now works?  Thanks a lot in advance!

Alistair, any result?
 
> Note you will need to try the ntfs driver itself and not ntfscp as libntfs 
> does not have these changes yet hence ntfscp will not work just the same 
> (it does not use the kernel driver at all, it only uses libntfs).

The latest ntfsprogs CVS has also these changes and every tool should work
fine with Vista (ntfscp, ntfsresize, ntfsundelete, ntfsclone, etc).

	Szaka

