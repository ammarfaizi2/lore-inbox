Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTIPHI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 03:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbTIPHI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 03:08:28 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:4481 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S261791AbTIPHI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 03:08:26 -0400
Message-ID: <3F66B671.1020805@longlandclan.hopto.org>
Date: Tue, 16 Sep 2003 17:06:25 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jeremyjin@nucleus.com
CC: linux-kernel@vger.kernel.org
Subject: Re: How to know current Kernel Configuration?
References: <0e851eca491344bebdb7b1a70a1bc608.jeremyjin@nucleus.com>
In-Reply-To: <0e851eca491344bebdb7b1a70a1bc608.jeremyjin@nucleus.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

jeremyjin@nucleus.com wrote:

| And I want to keep most configuration settings because I think these
settings should be pretty good,
| how can I know the current configuration of the current kernel? I know
make has a option "make oldconfig",
| but seems like it is the old configuration of the last times "make",
not the one of current running kernel.

Ahh, it's using the default configuration from the linux source, I'm not
sure where it's stored, somewhere in arch/i386... as far as I know.

However, Red Hat stores their version of the .config file in /boot as
config-`uname -r`.  So copy this to your kernel source directory as
.config, then try make oldconfig, etc...

A quick way of doing this... (assuming you are in the kernel source
directory)

# cp /boot/config-`uname -r` .config

Then run...

# make oldconfig
# make xconfig, menuconfig or config	- optional
# make dep bzImage modules modules_install - usual build procedure.

| Is there any command to list all current running linux kernel
configuration which is used to compile that version?
Not in 2.4.x as far as I know, but there is a virtual file in /proc
(/proc/ikconfig or something like that I think) that does this.

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

iD8DBQE/ZrZxIGJk7gLSDPcRAg5/AJ0d9VzrldoRxWbEeaGMW4KIP5dMpgCePHjw
wmkxGNq+SthHSBSeo+XQBKY=
=XfjP
-----END PGP SIGNATURE-----

