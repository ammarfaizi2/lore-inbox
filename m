Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVIIMCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVIIMCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVIIMCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:02:48 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:18048 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932510AbVIIMCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:02:47 -0400
Date: Fri, 9 Sep 2005 15:02:43 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/25] NTFS: Allow highmem	kmalloc()	in	ntfs_malloc_nofs()
 and add _nofail() version.
In-Reply-To: <1126266702.32261.5.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0509091453050.29168@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk> 
 <84144f0205090903366454da6@mail.gmail.com>  <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
  <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI> 
 <1126265138.24291.21.camel@imp.csi.cam.ac.uk> 
 <Pine.LNX.4.58.0509091426510.28121@sbz-30.cs.Helsinki.FI> 
 <1126266508.32261.3.camel@imp.csi.cam.ac.uk> <1126266702.32261.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Anton Altaparmakov wrote:
> > I completely disagree with you given that this is not "inventing [...]
> > own memory allocators", it is just a convenient short hand.  I am sure a
> > lot of people would agree with you though.  It is just a matter of
> > personal preference.
> 
> I should add that this is not ntfs only, the idea is from another file
> system which uses it, too.  Can't remember which one it was, though (xfs
> maybe?).

Indeed. It is not just a matter of personal preference but also a matter 
of subsystems introducing duplicate code like this. Quick grepping shows 
UDF doing same thing  and XFS doing slightly differently but I am pretty 
sure I've seen it elsewhere too.

				Pekka
