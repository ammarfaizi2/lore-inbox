Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVAYAJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVAYAJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVAYAHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:07:36 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:17111 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261703AbVAYAEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:04:53 -0500
Message-ID: <41F58D25.1000203@comcast.net>
Date: Mon, 24 Jan 2005 19:04:53 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: undefined references
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

icebox linux-2.6.10-grs # make
  CHK     include/linux/version.h
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
fs/built-in.o(.text+0xe413): In function `link_path_walk':
: undefined reference to `gr_inode_follow_link'
fs/built-in.o(.text+0xe933): In function `link_path_walk':
: undefined reference to `gr_inode_follow_link'
fs/built-in.o(.text+0x10c28): In function `sys_link':
: undefined reference to `gr_inode_hardlink'
fs/built-in.o(.text+0x10c52): In function `sys_link':
: undefined reference to `gr_inode_handle_create'
make: *** [.tmp_vmlinux1] Error 1

What would cause this kind of error?

I'm messing with reimplementing LSM from scratch and have a patch for
what I'm doing if anyone wants to communicate on this; it's pretty much
an academic endeavor (learn to code in the kernel, learn how lsm was
created, learn how GrSecurity's codebase works).
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9Y0lhDd4aOud5P8RAmGxAJ9XZESD1nHO7mEIA7Bw0YCC/ns3KACfSgLF
4XRkAjHoayXprZR1Ma/0doI=
=LqFc
-----END PGP SIGNATURE-----
