Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQKSX6U>; Sun, 19 Nov 2000 18:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbQKSX6K>; Sun, 19 Nov 2000 18:58:10 -0500
Received: from 213-123-73-213.btconnect.com ([213.123.73.213]:34571 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129572AbQKSX6A>;
	Sun, 19 Nov 2000 18:58:00 -0500
Date: Sun, 19 Nov 2000 23:29:48 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: VFS busy inodes after umount -- have a nice day...
Message-ID: <Pine.LNX.4.21.0011192326060.3837-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is how I manage to hit this under 2.4.0-test11-pre6

1. mkfs an ext2 filesystem on a 36G disk

2. do a complex combination of data and metadata io on it by means
  of SPECsfs with LOADs high enough to run out of space

3. observe that both high and low memory are almost zero, i.e. about 2M
each (total is 6G)

now try to umount the filesystem and you'll get the above. I will try
test11-pre7 tomorrow...

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
