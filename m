Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRAYACf>; Wed, 24 Jan 2001 19:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132111AbRAYACZ>; Wed, 24 Jan 2001 19:02:25 -0500
Received: from mail3.bigmailbox.com ([209.132.220.34]:46597 "EHLO
	mail3.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S129413AbRAYACO>; Wed, 24 Jan 2001 19:02:14 -0500
Date: Wed, 24 Jan 2001 16:02:04 -0800
Message-Id: <200101250002.QAA13445@mail3.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [198.147.65.9]
From: "First Name Last Name" <qkholland@my-deja.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-pre10 Hard lockup writing to fs on loop devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing hard lockup without OOPS when I write
60-40MB into a filesystem created on a regular file via
loop device, and the problem is quite reproducible.
Is anybody else suffering from a similar problem?

# mount | grep export/scratch
/dev/hda9 on /export/scratch type ext2 (rw)
# dd if=/dev/zero of=/export/scratch/F bs=1M count=420
# echo yes | mke2fs /export/scratch/F
# mount -o loop /export/scratch/F /mnt
# tar cf - . | ( cd /mnt && tar xfp - )


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
