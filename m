Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJ0S01>; Sat, 27 Oct 2001 14:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274603AbRJ0S0Q>; Sat, 27 Oct 2001 14:26:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13013 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274434AbRJ0S0N>;
	Sat, 27 Oct 2001 14:26:13 -0400
Date: Sat, 27 Oct 2001 14:26:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: alain@linux.lu
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <200110271800.f9RI0M803440@hitchhiker.org.lu>
Message-ID: <Pine.GSO.4.21.0110271422520.21545-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	BTW, here's one more devfs rmmod race: check_disk_changed() in
fs/devfs/base.c.  Calling ->check_media_change() with no protection
whatsoever.  If rmmod happens at that point...

