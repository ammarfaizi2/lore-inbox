Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbRETUMJ>; Sun, 20 May 2001 16:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbRETUL7>; Sun, 20 May 2001 16:11:59 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:42387 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S262212AbRETULr>; Sun, 20 May 2001 16:11:47 -0400
Message-ID: <3B0824E1.4FEE834F@pp.inet.fi>
Date: Sun, 20 May 2001 23:11:13 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: spam goes to /dev/null <spam-goes-to-dev-null@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: serpent loopback crypto "EXT2-fs: group descriptors corrupted"
In-Reply-To: <01df01c0e0a6$bfb9ed40$0100005a@host1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spam goes to /dev/null wrote:
> i created a 10mb file called .enc2 with random data and ran "# losetup -e
> serpent -k 128 /dev/loop0 /mnt/hda7/.enc2"
> then i ran "# mke2fs /dev/loop0" and tried to "# mount /dev/loop0 /enc". but
> i get the following error messages when trying to mount:
> 
> May 19 21:32:10 HOST2 kernel: EXT2-fs error (device loop(7,0)):
> ext2_check_descriptors: Block bitmap for group 16 not in group (block 0)!
> May 19 21:32:10 HOST2 kernel: EXT2-fs: group descriptors corrupted !
> 
> im using kernel 2.4.4 patched with crypto patch 2.4.3.1 [and util linux
> 2.11a patched with the patch from that crypto patch]
> i also got the same errors with a 2gb file and by creating the loop device
> directly on my 19.5gb /dev/hda7
> i tried a few times again and sometimes the encrypted loopback fs works
> perfectly, sometimes the error occurs!?
> anyone got an idea what this is!? i will supply more information on request

International crypto patch is misdesigned and broken, period. If you don't
want to play russian roulette with your data, you should consider using
loop-AES package. loop-AES announcement is here:

    http://mail.nl.linux.org/linux-crypto/2001-05/msg00003.html

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
