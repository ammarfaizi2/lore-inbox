Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261785AbSJNBDo>; Sun, 13 Oct 2002 21:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261787AbSJNBDo>; Sun, 13 Oct 2002 21:03:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23467 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261785AbSJNBDn>;
	Sun, 13 Oct 2002 21:03:43 -0400
Date: Sun, 13 Oct 2002 21:09:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rob Landley <landley@trommello.org>
cc: Nick LeRoy <nleroy@cs.wisc.edu>, Hans Reiser <reiser@namesys.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 - (NUMA)) (fwd)
In-Reply-To: <Pine.GSO.4.21.0210132106460.9247-100000@steklov.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0210132107020.9247-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Logically, the second /var mount should be "mount --move /initrd/var /var", 
> followed by "umount /initrd" to free up the initrd memory.  Right now it's 
> doing "mount -n --bind /initrd/var /var", because /etc is a symlink into /var 
> (has to remain editable, you see), and this way the information about which 
> partition var actually is can be kept in one place.  (This is an 
> implementation detail: I could have used volume labels instead.)
> 
> The point is, right now I can't free the initial ramdisk because it has an 
> active mount point under it..

umount -l
mount --move


