Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132421AbRDWWX6>; Mon, 23 Apr 2001 18:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRDWWWy>; Mon, 23 Apr 2001 18:22:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17352 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132428AbRDWWVw>;
	Mon, 23 Apr 2001 18:21:52 -0400
Date: Mon, 23 Apr 2001 18:21:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <Pine.GSO.4.21.0104121217580.19944-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104231814030.4968-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Alexander Viro wrote:

> 	Folks, IMO ext2-dir-patch got to the stable stage. Currently
> it's against 2.4.4-pre2, but it should apply to anything starting with
> 2.4.2 or so.
> 
> 	Ted, could you review it for potential inclusion into 2.4 once
> it gets enough testing? It's ext2-only (the only change outside of
> ext2 is exporting waitfor_one_page()), it doesn't change fs layout,
> it seriously simplifies ext2/dir.c and ext2/namei.c and it gives better
> VM behaviour.

	Previous variant left junk in ->d_type of directory entries
on "old" filesystems (i.e. ones where it should be zeroed). Harmless
(on these filesystems readdir() returned DT_UNKNOWN anyway), but
it PO'd fsck and was the wrong thing anyway.

	Fixed and rediffed against current tree (2.4.4-pre6). Folks,
please help with testing.

 	Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4-pre6.gz

							Cheers,
								Al

