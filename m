Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSGAH5r>; Mon, 1 Jul 2002 03:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSGAH5q>; Mon, 1 Jul 2002 03:57:46 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:18189 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S315445AbSGAH5p>; Mon, 1 Jul 2002 03:57:45 -0400
Message-ID: <3D200BF6.3A6D9B59@aitel.hist.no>
Date: Mon, 01 Jul 2002 09:59:50 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, davej@suse.de
Subject: 2.5.24-dj1,smp,ext2,raid0: I got random zero blocks in my files.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.24-dj1 gave me files with zeroed blocks inside.
What I did:  I untarred the source for lyx 1.2.0
and tried to compile it, several times.

gcc and make choked on occational blocks of zeroes
inside files, different places each time.
Going back to 2.5.18 fixed it.

This isn't all that surprising considering that
the raid driver logs complaints about requests
bigger than 32k, which is the stripe size.
I believed this worked by retrying with much smaller
requests, perhaps I am wrong?

The filesystems use 4k blocks.
I haven't seen any trouble on non-raid or raid-1
partitions.

Helge Hafting
