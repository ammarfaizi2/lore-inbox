Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131654AbRCOJyw>; Thu, 15 Mar 2001 04:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131656AbRCOJym>; Thu, 15 Mar 2001 04:54:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:37519 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131654AbRCOJyc>;
	Thu, 15 Mar 2001 04:54:32 -0500
Date: Thu, 15 Mar 2001 10:52:25 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103150952.KAA451302.aeb@vlet.cwi.nl>
To: acahalan@cs.uml.edu, viro@math.psu.edu
Subject: Re: [PATCH] Improved version reporting
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, linus@transmeta.com,
        linux-kernel@vger.kernel.org, rhw@memalpha.cx,
        seberino@spawar.navy.mil
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: "Albert D. Cahalan" <acahalan@cs.uml.edu>

    > On Wed, 14 Mar 2001 Andries.Brouwer@cwi.nl wrote:

    >>> +o  Console Tools      #   0.3.3        # loadkeys -V
    >>> +o  Mount              #   2.10e        # mount --version
    >>
    >> Concerning mount: (i) the version mentioned is too old,

    Exactly why? Mere missing features don't make for a required
    upgrade. Version number inflation should be resisted.

These days you can mount filesystems several places.
That means that the choice one used to have -- after
	# mount dev dir
both
	# umount dev
and
	# umount dir
would unmount -- has disappeared, and only
	# umount dir
is (guaranteed to be) right today.
These days you can mount several filesystems at the same mount point.
The old mount does not understand this at all.
Recent versions of mount act better in this respect,
even though it is still easy to confuse them.

Such things mean that it is best to have a really recent mount
(although, of course, if you only want the mount(2) system call
executed some five year old version will also do that for you).

On the other hand, there are no important changes between
mount-2.10d and 2.10e, so I see no justification for writing 2.10e.
It is difficult to say what the "right" version is. There is a
long series of minor improvements. Probably I would write 2.10r.

Andries
