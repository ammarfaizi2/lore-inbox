Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAOWsL>; Mon, 15 Jan 2001 17:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRAOWsB>; Mon, 15 Jan 2001 17:48:01 -0500
Received: from isis.telemach.net ([213.143.65.10]:64262 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S129562AbRAOWrx>;
	Mon, 15 Jan 2001 17:47:53 -0500
Message-ID: <3A637E15.DDC8C38@telemach.net>
Date: Mon, 15 Jan 2001 23:47:49 +0100
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FS corruption on 2.4.0-ac8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was running 2.4.0test10pre5 happily for months and wanted to see how
things stand in the 'latest stuff'. Here's what i found:

I compiled 2.4.0-ac8 with nearly the same .config as test10pre5 (with
latest gcc on rh7). Then i booted it and used X for some normal browsing
and mp3s. Performance was poor, responsivness also, even the mouse
stopped responding for a couple of seconds at a time, a lot of disk
trashing & so on. I deceided to boot test10 back, and there was a nasty
suprise: fsck found filesystem with errors, and LOTS of them ... i had
to hold down 'y' for almost 5 minutes ... :)

Then i examined the logs for what would be the cause for this ... and
here's what 2.4.0-ac8 left in the logs:

Jan 14 16:26:47 open kernel: ee_blocks: Freeing blocks not in datazone -
block = 979727457, count = 1
Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
ext2_free_blocks: Freeing blocks not in datazone - block = 1769096736,
count = 1
Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
ext2_free_blocks: Freeing blocks not in datazone - block = 842080300,
count = 1
Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
ext2_free_blocks: Freeing blocks not in datazone - block = 1851869728,
count = 1
Jan 14 16:26:47 open kernel: EXT2-fs error (device md(9,1)):
ext2_free_blocks: Freeing blocks not in datazone - block = 808464928,
count = 1
...
and so on for about 150 such lines in 3 seconds.

There is something not that usual about my setup: i run raid1 /boot and
raid5 root with one disk disconnected (its simply too loud...), so the
array is in degraded mode all the time. Other hardware is more or less
standard, p200 classic, 430vx board, adaptec2940u, 64mb ram.

Is this a known problem? If it's not, please advise me on how to provide
more usefull informations.


-- 

Jure Pecar
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
