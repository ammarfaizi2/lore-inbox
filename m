Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281083AbRKKVWr>; Sun, 11 Nov 2001 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281082AbRKKVWi>; Sun, 11 Nov 2001 16:22:38 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:21023 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S281072AbRKKVWX>; Sun, 11 Nov 2001 16:22:23 -0500
Message-ID: <3BEEED3E.58867BFE@mindspring.com>
Date: Sun, 11 Nov 2001 13:27:26 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loop back broken in 2.2.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compile 2.2.14.

Then

# modprobe -a loop
/lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
deactivate_page
/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod
/lib/modules/2.4.14/kernel/drivers/block/loop.o failed
/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed

do recursive grep through kernel tree:

# rgrep -rl  deactivate_page *
drivers/block/loop.c
drivers/block/loop.o

Is there a fix for this?

Joe

