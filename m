Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRJ0UJM>; Sat, 27 Oct 2001 16:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRJ0UJD>; Sat, 27 Oct 2001 16:09:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13793 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276982AbRJ0UIt>;
	Sat, 27 Oct 2001 16:08:49 -0400
Date: Sat, 27 Oct 2001 16:06:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110271558430.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and one more - devfs_unregister() on a directory happening when
mknod() in that directory sleeps in create_entry() (on kmalloc()).

Do you ever read your own code?  It's not like this stuff was hard
to find - I'm just poking into random places and every damn one
contains a hole.  Sigh...

Oh, BTW - here's another one:  think what happens if tree-walking in
unregister() steps on the entry we are currently removing in
devfs_unlink().

