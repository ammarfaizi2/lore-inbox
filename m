Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUEYNZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUEYNZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264749AbUEYNZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:25:38 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:39404 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264746AbUEYNZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:25:30 -0400
Message-ID: <40B34946.9030500@g-house.de>
Date: Tue, 25 May 2004 15:25:26 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: baptiste coudurier <baptiste.coudurier@free.fr>
Subject: Re: MORE THAN 10 IDE CONTROLLERS
References: <40B23D4A.4010708@free.fr>
In-Reply-To: <40B23D4A.4010708@free.fr>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

baptiste coudurier schrieb:
| Does anyone know what are major/minors for hdu, hdv, hdw, hdx ?

not being a professional, i see:

evil@sheep:~$ la /dev/hd?
brw-rw----    1 root     disk       3,   0 2004-03-10 11:33 /dev/hda
brw-rw----    1 root     disk       3,  64 2004-03-10 11:33 /dev/hdb
brw-rw----    1 root     disk      22,   0 2004-03-10 11:33 /dev/hdc
brw-rw----    1 root     disk      22,  64 2004-03-10 11:33 /dev/hdd
brw-rw----    1 root     disk      33,   0 2004-03-10 11:40 /dev/hde
brw-rw----    1 root     disk      33,  64 2004-03-10 11:40 /dev/hdf
brw-rw----    1 root     disk      34,   0 2004-03-10 11:40 /dev/hdg
brw-rw----    1 root     disk      34,  64 2004-03-10 11:40 /dev/hdh

so, it's a major number for every controller (e.g. "22" for hdc+hdd each
belonging to one controller). hdi+hdj would be major 35, minor [0|64] ?
i'd try this out for hdx and further...

did you try devfs/udev? perhaps it could solve this by itsself....?

Christian.

PS: maybe Documentation/devices.txt helps out too.

- --
BOFH excuse #75:

There isn't any problem
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAs0lG+A7rjkF8z0wRAmp5AJ985JGLXpxX5rSJnQM0GJNq0LkcIQCfT4hH
kj4lr37B1urPVTAMiLbMXlE=
=fohg
-----END PGP SIGNATURE-----
