Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbRE0GAE>; Sun, 27 May 2001 02:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbRE0F7y>; Sun, 27 May 2001 01:59:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39603 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262769AbRE0F7p>;
	Sun, 27 May 2001 01:59:45 -0400
Date: Sun, 27 May 2001 01:59:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Rankin <rankinc@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: RE: Linux-2.4.5 and Reiserfs, oops!
In-Reply-To: <200105270536.f4R5agv05179@wellhouse.underworld>
Message-ID: <Pine.GSO.4.21.0105270151060.1945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Chris Rankin wrote:

> Hi,
> 
> Thanks for the patch; I successfully unmounted my reiserfs USB Zip 250
> MB disc. However, the box then locked up hard when I unmounted an NFS
> mount and tried to switch to another virtual console.

That's... interesting. With that patch changes to fs/super.c should make
no difference whatsoever.

OK, can you reproduce NFS lockup on 2.4.5-pre5 (without that patch)
and on 2.4.5-pre3 (ditto)? 

There were NFS changes in -pre4 and -pre5 and umount ones in -pre6. The
latter need the patch I've posted, so vanilla -pre5 and -pre3 are the
first candidates for checking.

