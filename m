Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVA0AXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVA0AXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVA0AVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:21:36 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:33765 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262495AbVAZXEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:04:35 -0500
Message-ID: <41F82218.1080705@comcast.net>
Date: Wed, 26 Jan 2005 18:04:56 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc parent &proc_root == NULL?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

proc_misc_init() has both these lines in it:

entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);

Both entries show up in /proc, as /proc/kmsg and /proc/kcore.  So I ask,
as I can't see after several minutes of examination, what's the
difference?  Why is NULL used for some and &proc_root used for others?

I'm looking at 2.6.10

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+CIYhDd4aOud5P8RAsVPAKCIzjicPM4e9FrAOFUgf3JJIV8GgACfWh4a
iX1Z8mKOX7RRzHWVnKhx1mQ=
=+MqB
-----END PGP SIGNATURE-----
