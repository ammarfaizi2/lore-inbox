Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276463AbRJCQSl>; Wed, 3 Oct 2001 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276452AbRJCQSb>; Wed, 3 Oct 2001 12:18:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30218 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276451AbRJCQSW>; Wed, 3 Oct 2001 12:18:22 -0400
Date: Wed, 3 Oct 2001 09:18:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Vladimir V. Saveliev" <vs@namesys.com>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Re: bug? in using generic read/write functions to
 read/write block devices  in 2.4.11-pre2
In-Reply-To: <Pine.GSO.4.21.0110030839160.21861-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110030916530.9427-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, Alexander Viro wrote:
>
> Ehh... Linus, both blkdev_get() and blkdev_open() should set ->i_blkbits.

Duh. I couldn't even _imagine_ that we'd be so stupid to have duplicated
that code twice instead of just having blkdev_open() call blkdev_get().

Thanks.

		Linus

