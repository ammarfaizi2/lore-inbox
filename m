Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319558AbSH3MkC>; Fri, 30 Aug 2002 08:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319559AbSH3MkC>; Fri, 30 Aug 2002 08:40:02 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13060 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319558AbSH3MkB>; Fri, 30 Aug 2002 08:40:01 -0400
Message-ID: <3D6F6874.40BE5519@aitel.hist.no>
Date: Fri, 30 Aug 2002 14:43:32 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.32 oops during reboot 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.32 oopsed during shutdown, terminating the reboot process.
The machine wouldn't die this way.

Of course there were no logs, so I wrote down
some numbers and looked them up later:

Unable to handle kernel paging request at d0c65498
eip: c019bb38  tty_register_devfs

call trace:
c0197077 disable_irq_nosync
c011f78d sys_reboot
c014gf40 posix_lock_file
c024be45 devinet_ioctl
c02175c7 sock_destroy_inode

process reboot exited with preempt count 2

UP kernel, with preempt & devfs

Helge Hafting
