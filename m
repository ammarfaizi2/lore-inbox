Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLaBoZ>; Sat, 30 Dec 2000 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135627AbQLaBoP>; Sat, 30 Dec 2000 20:44:15 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:17419
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129436AbQLaBoD>; Sat, 30 Dec 2000 20:44:03 -0500
Date: Sun, 31 Dec 2000 14:13:35 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Eric W. Biederman" <ebiederman@uswest.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
Message-ID: <20001231141335.B21365@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10012301214210.1017-100000@penguin.transmeta.com> <m1u27lpo1g.fsf@frodo.biederman.org> <20001231020234.A15179@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001231020234.A15179@athlon.random>; from andrea@suse.de on Sun, Dec 31, 2000 at 02:02:34AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 02:02:34AM +0100, Andrea Arcangeli wrote:

    Yes, we need to add one field to the in-core superblock to do
    this accounting.

How does this work for filesystems like reisefs which do tail merging
and other filesystems which might do sub-clock allocation?

We either need more than one field (or a byte counter) + lock or
perhaps a generic fields + callback to the fs itself.
    
    > estimate than just the data blocks it should not be hard to add
    > an extra callback to the filesystem.
    
    Yes, I was thinking at this callback too. Such a callback is
    nearly the only support we need from the filesystem to provide
    allocate on flush.

I think a callback is the way to go.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
