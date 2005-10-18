Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVJRTPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVJRTPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVJRTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:15:49 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:48776 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751168AbVJRTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:15:48 -0400
Message-ID: <4355494C.5090707@comcast.net>
Date: Tue, 18 Oct 2005 15:13:16 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Keep initrd tasks running?
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have no idea who's the best to ask for this.

I want to start a task in an initrd and have it stay running after init
is started.  Pretty much:


 - kernel boot
 - initrd loaded
 - linuxrc executes
 - /bin/mydaemon runs
 - mount rootfs
 - pivot_root
 - exec /sbin/init (PID=1; linuxrc and sh is replaced)
 - mydaemon keeps running, reparented under init, uninterrupted


What's the feasibility of this without the system balking and vomiting
chunks everywhere?  I'm pretty sure 'exec /sbin/init' from linuxrc
(PID=1) will replace the process image of sh (linuxrc) with init,
keeping PID=1; but I'm worried this may terminate children too.  Haven't
tried.

(this actually has a useful application)
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVUlKhDd4aOud5P8RAuTeAJ9z7F+aeLZgnHzuzyviSXhJG/d5egCcCoxs
GpD7wLP+ZngCsYFLGsmEXb0=
=w6xA
-----END PGP SIGNATURE-----
