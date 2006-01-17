Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWAQSxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWAQSxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWAQSxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:53:15 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63400 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932231AbWAQSxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:53:14 -0500
Message-ID: <43CD3CE4.3090300@comcast.net>
Date: Tue, 17 Jan 2006 13:52:20 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Huge pages and small pages. . .
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is there anything in the kernel that shifts the physical pages for 1024
physically allocated and contiguous virtual pages together physically
and remaps them as one huge page?  This would probably work well for the
low end of the heap, until someone figures out a way to tell the system
to free intermittent pages in a big mapping (if the heap has an
allocation up high, it can have huge, unused areas that are allocated).
 It may possibly work for disk cache as well, albeit I can't say for
sure if it's common to have a 4 meg contiguous section of program data
loaded.

Shifting odd huge allocations around would be neat to, re:

{2m}[4M  ]{2m}  ->  [4M  ][4M  ]

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzTzjhDd4aOud5P8RAud1AJ9MVy90XzvJWmgHmlBUdHcpsYNtWACfVxY6
f/jYDM1XiM8/09TfrzEDI3w=
=CsLK
-----END PGP SIGNATURE-----
