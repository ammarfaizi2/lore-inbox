Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271747AbRICQnw>; Mon, 3 Sep 2001 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271748AbRICQnn>; Mon, 3 Sep 2001 12:43:43 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:47813 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S271747AbRICQng>; Mon, 3 Sep 2001 12:43:36 -0400
Message-ID: <3B93B32A.69D25916@pp.inet.fi>
Date: Mon, 03 Sep 2001 19:43:22 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Announce loop-AES-v1.4d file/swap crypto package
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[linux-kernel also CC'd due to recent encrypted swap discussion]

In short: If file and swap crypto is all you need, this package is a hassle
free replacement for international crypto patch and HVR's crypto-api.

This package provides loadable Linux kernel module (loop.o) that has AES
cipher built-in. The AES cipher can be used to encrypt local file systems
and disk partitions. For more information about compiling and using the
driver, see the README file in the package.

Features:
- GPL license.
- No source modifications to kernel. No patch hassles when you are upgrading
  your kernel.
- Works with all recent 2.4, 2.2 and 2.0 kernels, including distro vendor
  kernels. Encrypted disk images are compatible across all supported
  kernels.
- AES cipher is used in CBC mode. Supports 128, 192 and 256 bit keys.
- Passwords hashed with SHA-256, SHA-384 or SHA-512.
- 512 byte based IV. IV is immune to variations in transfer size and does
  not depend on file system block size.
- Device backed (partition backed) loop is capable of encrypting swap on 2.4
  kernels.

Changes since previous release:
- Little speed optimization in aes-glue.c
- External encryption module locking bug is fixed (kernel 2.4 only). This
  bug did not affect loop-AES operation at all. This fix is from Ingo
  Rohloff.
- On 2.4 kernels, device backed loop maintains private pre-allocated pool of
  RAM pages that are used when kernel is totally out of free RAM. This
  change also fixes stock loop.c sin of sleeping in make_request_fn().

Kernel 2.4 users who want to encrypt swap partitions should upgrade to this
version. No need to upgrade if you use older 2.2 or 2.0 kernels.

bzip2 compressed tarball is here:

    http://loop-aes.sourceforge.net/loop-AES-v1.4d.tar.bz2
    md5sum 404f82796bacc479deb266f13ec260b8

PGP signature file, my public key, and fingerprint here:

    http://loop-aes.sourceforge.net/loop-AES-v1.4d.tar.bz2.sign
    http://loop-aes.sourceforge.net/PGP-public-key.asc
    1024/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

Regards, 
Jari Ruusu <jari.ruusu@pp.inet.fi>

