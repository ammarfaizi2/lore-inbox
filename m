Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTIMMK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 08:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTIMMK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 08:10:29 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:15490 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S262094AbTIMMK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 08:10:28 -0400
Message-ID: <3F630930.2060706@longlandclan.hopto.org>
Date: Sat, 13 Sep 2003 22:10:24 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Somsak RAKTHAI <rsomsak@mor-or.pn.psu.ac.th>
CC: linux-kernel@vger.kernel.org
Subject: Re: st_options.h
References: <Pine.GSO.4.43.0309131716590.19568-100000@mor-or>
In-Reply-To: <Pine.GSO.4.43.0309131716590.19568-100000@mor-or>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Somsak RAKTHAI wrote:
|   I used Linux RedHat 7.2. My kernel is 2.4.7-10smp.

Any reason why you're running such an old kernel?  Linux 2.4.22 was
released a couple of weeks ago, and I'm guessing that 2.4.23 won't be
too far off.

My suggestion,

1.	Grab Linux 2.4.22 from ftp.kernel.org, and extract the source
	into /usr/src

2.	Copy your config file into the /usr/src/linux-2.4.22 directory
	(as .config).  You'll probably find it in
	/boot/config-2.4.7-10smp or something like that.  Simply run:

	cp /boot/config-2.4.7-10smp /usr/src/linux-2.4.22/.config

3.	Run the usual commands:
	make mrproper oldconfig dep bzImage modules modules_install

4.	Dump your kernel image into /boot and reconfigure your bootloader
(/etc/lilo.conf will be worth a look here).

	cp /usr/src/linux-2.4.22/arch/i386/boot/bzImage \
		/boot/vmlinuz-new

5.	Boot the kernel, give it a try.  If it works fine, then you can make
it your default kernel.
- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/YwkwIGJk7gLSDPcRAkSWAJ9bxhHQyB4fRZNEtNNVfIgFbHxzJwCdGuw/
Odp+bOov2zpV506ZlO0n6Ro=
=bjBy
-----END PGP SIGNATURE-----

