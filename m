Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132706AbRC2LFc>; Thu, 29 Mar 2001 06:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRC2LFP>; Thu, 29 Mar 2001 06:05:15 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53693 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132701AbRC2LE6>;
	Thu, 29 Mar 2001 06:04:58 -0500
Date: Thu, 29 Mar 2001 06:04:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Subject: [CFT][PATCH] namespaces - next variant
Message-ID: <Pine.GSO.4.21.0103290545060.29330-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, updated namespace patch is on
ftp.math.psu.edu/pub/viro/namespaces-b-S3-pre8.gz
It took longer than I expected - sorry about that.

News:
	* fix for long-standing races between rename() and umount()
	* much better scalability for case of multiple namespaces (cost of
	  traversing mountpoints is nearly constant instead of O(number of
	  namespaces)).
	* recursive bind (i.e. bind with submounts - pass MS_BIND|MS_REC in
	  flags)
	* sane refcounting for FS_SINGLE filesystems
	* fixes for assorted bugs in previous version
	* real cleanup of fs/super.c logics. Hell, it's almost documentable
	  now. Thing separated into namespace.c (vfsmount handling) and
	  super.c - both became readable.

It seems to be working here, but it obviously needs more testing. Patch
is against 2.4.3-pre8. As far as I'm concerned design-wise it's pretty close
to final - next pieces will go as incremental to it.

I'll start posting documentation when I'll be back from San Jose. Please,
help testing the thing - bug reports are more than welcome.
							Cheers,
								Al

