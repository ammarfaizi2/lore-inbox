Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265028AbRFUQpg>; Thu, 21 Jun 2001 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265029AbRFUQp0>; Thu, 21 Jun 2001 12:45:26 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:4250 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S265028AbRFUQpN>; Thu, 21 Jun 2001 12:45:13 -0400
Message-ID: <3B32242F.595A654C@pp.inet.fi>
Date: Thu, 21 Jun 2001 19:43:27 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: loop device broken in 2.4.6-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

File backed loop device on 4k block size ext2 filesystem:

debian:/root # dd if=/dev/zero of=file1 bs=1024 count=10
10+0 records in
10+0 records out
debian:/root # losetup /dev/loop0 file1
debian:/root # dd if=/dev/zero of=/dev/loop0 bs=1024 count=10 conv=notrunc
dd: /dev/loop0: No space left on device                   <=====ERROR=====
9+0 records in
8+0 records out
debian:/root # tune2fs -l /dev/hda1 2>&1| grep "Block size"
Block size:               4096
debian:/root # uname -a
Linux debian 2.4.6-pre5 #1 Thu Jun 21 14:27:25 EEST 2001 i686 unknown

Stock 2.4.5 and 2.4.5-ac15 don't have this problem.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
