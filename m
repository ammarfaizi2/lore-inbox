Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131598AbQKJTuf>; Fri, 10 Nov 2000 14:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbQKJTuZ>; Fri, 10 Nov 2000 14:50:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26058 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131598AbQKJTuM>;
	Fri, 10 Nov 2000 14:50:12 -0500
Date: Fri, 10 Nov 2000 14:50:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [RFC] crapectomy: CTL_ANY
Message-ID: <Pine.GSO.4.21.0011101445531.17943-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


% find . -type f | xargs grep -nw CTL_ANY
./kernel/sysctl.c:370:          if (n == table->ctl_name || table->ctl_name == CTL_ANY) {
./include/linux/sysctl.h:47:#define CTL_ANY             -1      /* Matches any name */

And no, there is no ctl_table that would be getting explicit -1 as ->ctl_name.
Unless somebody screams I'm removing that beast (how the hell did it get
there in the first place? Mind boggles...)
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
