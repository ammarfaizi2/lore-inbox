Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLFPnj>; Wed, 6 Dec 2000 10:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130746AbQLFPna>; Wed, 6 Dec 2000 10:43:30 -0500
Received: from web2007.mail.yahoo.com ([128.11.68.238]:46087 "HELO
	web2007.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129846AbQLFPnR>; Wed, 6 Dec 2000 10:43:17 -0500
Message-ID: <20001206151250.25734.qmail@web2007.mail.yahoo.com>
Date: Wed, 6 Dec 2000 07:12:50 -0800 (PST)
From: Tom Murphy <freyason@yahoo.com>
Subject: IDE fs corruption in 2.4.0-test11?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system running 2.4.0-test11 recently trashed itself and I was
wondering what steps I should take to ensure UDMA is running OK
and not trashing itself.

Are there options in hdparm that could conflict with 2.4's handling
of UDMA that would cause all writable partitions on the drive to
self-destruct? This is what happened to me last weekend except for
/usr, which was mounted read-only at the time.

2.4.0-test11 spontaneously just rebooted itself for no reason,
so I decided booting into 2.2.17 would be a good idea to check
to make sure everything was fine. 2.2.17 fsck'd all the partitions
and was happy and went on.

I then rebooted back into 2.4.0-test11 (or tried to) and LILO greeted
me with a lovely "LIL-".

I booted from rescue disks and attempted to fsck the partitions.
I had to specify the superblock and eventually got a huge string of
"Illegal blocks in inodes". After fscking "/", I noticed /etc was
gone. Same thing happened in /var and /home with basically no
data being fixed or recovered. I had to reformat everything.

Which options in hdparm are considered dangerous to use in 2.4?
I had 32-bit I/O set (-c 1) , DMA set on (-d 1), multiple sector I/O
(-m 16). The drive in question is a 45 gigabyte Western Digital Caviar
drive.

I heard the multiple sector I/O may be bad for the drives.. is this
true?

Thanks in advance,

   Tom

ps. Please reply directly to my e-mail address as I am not
subscribed to linux-kernel. 

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
