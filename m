Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbRE0IOi>; Sun, 27 May 2001 04:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbRE0IO2>; Sun, 27 May 2001 04:14:28 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:5765 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262791AbRE0IOI>; Sun, 27 May 2001 04:14:08 -0400
Date: Sun, 27 May 2001 01:13:54 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Re: Linux-2.4.5 and Reiserfs, oops!
In-Reply-To: <Pine.GSO.4.21.0105270151060.1945-100000@weyl.math.psu.edu>
To: viro@math.psu.edu (Alexander Viro)
Cc: linux-kernel@vger.kernel.org
Message-id: <200105270813.f4R8DtF06292@wellhouse.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have now reproduced the lockup in 2.4.4, having passed the
additional boot parameters "nmi_watchdog=1 noapic".

To be more specific, it happens when switching from a vc running a
text console to the vc running X. I'm thinking that maybe the umount
NFS is a coincidence / red herring.

Chris

My video card is a Matrox G400 AGP 32MB with TV-OUT, and I'm not using
the frame buffer driver.

> On Sat, 26 May 2001, Chris Rankin wrote:
> 
> > Hi,
> > 
> > Thanks for the patch; I successfully unmounted my reiserfs USB Zip 250
> > MB disc. However, the box then locked up hard when I unmounted an NFS
> > mount and tried to switch to another virtual console.
> 
> That's... interesting. With that patch changes to fs/super.c should make
> no difference whatsoever.
> 
> OK, can you reproduce NFS lockup on 2.4.5-pre5 (without that patch)
> and on 2.4.5-pre3 (ditto)? 
> 
> There were NFS changes in -pre4 and -pre5 and umount ones in -pre6. The
> latter need the patch I've posted, so vanilla -pre5 and -pre3 are the
> first candidates for checking.
> 

