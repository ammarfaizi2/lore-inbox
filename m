Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270025AbRHQJ6D>; Fri, 17 Aug 2001 05:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270042AbRHQJ5x>; Fri, 17 Aug 2001 05:57:53 -0400
Received: from picard.csihq.com ([204.17.222.1]:21423 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S270025AbRHQJ5h>;
	Fri, 17 Aug 2001 05:57:37 -0400
Message-ID: <001f01c12702$f5fd98a0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Recommended change
Date: Fri, 17 Aug 2001 05:57:01 -0400
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

I upgraded to e2fsprog-1.23 and LInux 2.4.8 yesterday and saw this:

Aug 16 08:58:20 yeti kernel: md: fsck.ext3(pid 207) used obsolete MD ioctl,
upgrade your software to use new ictls.

Do you suppose we could change the printk line to actually output the ioctl
that was requested?

i.e.:

/usr/src/linux/drivers/md/md.c

                default:
                        printk(KERN_WARNING "md: %s(pid %d) used obsolete MD
ioctl(%d), upgrade your software to use new ictls.\n", current->comm,
current->pid, cmd);

Might help debugging this stuff a little easier.

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

