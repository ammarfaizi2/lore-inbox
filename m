Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271610AbRHUIfB>; Tue, 21 Aug 2001 04:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271609AbRHUIew>; Tue, 21 Aug 2001 04:34:52 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:16652 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S271608AbRHUIeo>; Tue, 21 Aug 2001 04:34:44 -0400
Message-Id: <200108210834.f7L8Ysk09023@mail.swissonline.ch>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Kristian <kristian@korseby.net>
Subject: Re: massive filesystem corruption with 2.4.9
Date: Tue, 21 Aug 2001 10:34:49 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <3B821509.8000006@korseby.net>
In-Reply-To: <3B821509.8000006@korseby.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i had similar problems with 2.4.6. unfortunately i didn't save the errors so
i can't compare the msg's. i just can say that with 2.4.6 it destroyed the
ext2 on a 40GB and 60GB maxtor disk. since then my nfs server is running 
2.2.19 with works fine (with minor promblems*).

* after a client mounted an exprots once. i cant unmount that partition on 
the server after the client unmounted the exports.



On Tuesday 21 August 2001 10:00, Kristian wrote:
> Hello.
>
> Since linux-2.4.5 always the same errors occur sporadically after the cold
> boot in the morning. (My computer is powered off during the night.) Every
> second day I noticed my syslog sais something like the  following:
>
> Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_new_block: Allocating block in system zone - block = 3
> Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_free_blocks: Freeing blocks in system zones - Block = 4, count = 1
> Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_new_block: Allocating block in system zone - block = 37
> Aug 21 09:01:06 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_new_block: Allocating block in system zone - block = 45
> Aug 21 09:01:07 adlib kernel: mtrr: base(0x42000000) is not aligned on a
> size(0x1800000) boundary
> Aug 21 09:01:09 adlib last message repeated 2 times
> Aug 21 09:01:26 adlib PAM_unix[1929]: (login) session opened for user root
> by LOGIN(uid=0)
> Aug 21 09:01:26 adlib  -- root[1929]: ROOT LOGIN ON tty1
> Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_free_blocks: Freeing blocks in system zones - Block = 41, count = 4
> Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_new_block: Allocating block in system zone - block = 4
> Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_new_block: Allocating block in system zone - block = 7
> Aug 21 09:01:30 adlib kernel: EXT2-fs error (device ide0(3,5)):
> ext2_free_blocks: Freeing blocks in system zones - Block = 8, count = 2
>
> Today it destroyed my super block and all my root-directories were placed
> in /lost+found. I rescued everything with e2fsck-1.14 from a very old
> rescue-disk and then again with 1.23, renaming and replacing the
> directories by hand. A lot of devices and some .h-files were not
> recoverable.
>
> These fatal errors are occuring since 2.4.5 (2.4.8 I've not tested.). When
> I work with 2.4.4 everything is fine !
>
> I already use the newest version of e2fsck (1.23) and util-linux (2.11f).
> My RedHat (Rotkäppchen) 6.2 is rather old, but I don't like gcc 2.96 at
> all.
>
> I posted this report as the errors occured after a complete crash with
> 2.4.6 also to the ext2-developers directly but they didn't answered.
>
> Maybe you could help me here ?
>
> Kristian
>
> ·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
>
>                             :: http://www.korseby.net
>                             :: http://www.tomlab.de
>
> kristian@korseby.net ....::
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
christian widmer
zurlindenstrasse 294, 8003 zurich, switzerland
email:  cwidmer@iiic.ethz.ch
phone: ++41 (0)1 491 03 68
