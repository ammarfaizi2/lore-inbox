Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbRESVBA>; Sat, 19 May 2001 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbRESVAu>; Sat, 19 May 2001 17:00:50 -0400
Received: from pop.gmx.net ([194.221.183.20]:39415 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261339AbRESVAj>;
	Sat, 19 May 2001 17:00:39 -0400
Message-ID: <01df01c0e0a6$bfb9ed40$0100005a@host1>
From: "spam goes to /dev/null" <spam-goes-to-dev-null@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: serpent loopback crypto "EXT2-fs: group descriptors corrupted"
Date: Sat, 19 May 2001 23:00:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i created a 10mb file called .enc2 with random data and ran "# losetup -e
serpent -k 128 /dev/loop0 /mnt/hda7/.enc2"
then i ran "# mke2fs /dev/loop0" and tried to "# mount /dev/loop0 /enc". but
i get the following error messages when trying to mount:

May 19 21:32:10 HOST2 kernel: EXT2-fs error (device loop(7,0)):
ext2_check_descriptors: Block bitmap for group 16 not in group (block 0)!
May 19 21:32:10 HOST2 kernel: EXT2-fs: group descriptors corrupted !

im using kernel 2.4.4 patched with crypto patch 2.4.3.1 [and util linux
2.11a patched with the patch from that crypto patch]
i also got the same errors with a 2gb file and by creating the loop device
directly on my 19.5gb /dev/hda7
i tried a few times again and sometimes the encrypted loopback fs works
perfectly, sometimes the error occurs!?
anyone got an idea what this is!? i will supply more information on request


thx for your help
- peter k.

ps: dont kill me if im doing something wrong, this is the first time im
mailing to this list ;)

