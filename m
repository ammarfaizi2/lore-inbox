Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271586AbRHUIAs>; Tue, 21 Aug 2001 04:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271587AbRHUIAj>; Tue, 21 Aug 2001 04:00:39 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:6842 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S271586AbRHUIAT>; Tue, 21 Aug 2001 04:00:19 -0400
Message-ID: <3B821509.8000006@korseby.net>
Date: Tue, 21 Aug 2001 10:00:09 +0200
From: Kristian <kristian@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: massive filesystem corruption with 2.4.9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since linux-2.4.5 always the same errors occur sporadically after the cold boot
     in the morning. (My computer is powered off during the night.) Every second
day I noticed my syslog sais something like the  following:

Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)): ext2_new_block:
Allocating block in system zone - block = 3
Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: Freeing blocks in system zones - Block = 4, count = 1
Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)): ext2_new_block:
Allocating block in system zone - block = 37
Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)): ext2_new_block:
Allocating block in system zone - block = 45
Aug 21 09:01:07 adlib kernel: mtrr: base(0x42000000) is not aligned on a
size(0x1800000) boundary
Aug 21 09:01:09 adlib last message repeated 2 times
Aug 21 09:01:26 adlib PAM_unix[1929]: (login) session opened for user root by
LOGIN(uid=0)
Aug 21 09:01:26 adlib  -- root[1929]: ROOT LOGIN ON tty1
Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: Freeing blocks in system zones - Block = 41, count = 4
Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)): ext2_new_block:
Allocating block in system zone - block = 4
Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)): ext2_new_block:
Allocating block in system zone - block = 7
Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)):
ext2_free_blocks: Freeing blocks in system zones - Block = 8, count = 2

Today it destroyed my super block and all my root-directories were placed in
/lost+found. I rescued everything with e2fsck-1.14 from a very old rescue-disk
and then again with 1.23, renaming and replacing the directories by hand. A lot
of devices and some .h-files were not recoverable.

These fatal errors are occuring since 2.4.5 (2.4.8 I've not tested.). When I
work with 2.4.4 everything is fine !

I already use the newest version of e2fsck (1.23) and util-linux (2.11f). My
RedHat (Rotkäppchen) 6.2 is rather old, but I don't like gcc 2.96 at all.

I posted this report as the errors occured after a complete crash with 2.4.6
also to the ext2-developers directly but they didn't answered.

Maybe you could help me here ?

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                            :: http://www.korseby.net
                            :: http://www.tomlab.de
kristian@korseby.net ....::



