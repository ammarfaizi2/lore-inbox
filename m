Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTEWARF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTEWARF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:17:05 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:25615 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S263462AbTEWARD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:17:03 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D3F7@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Julien Oster'" <lkml@mf.frodoid.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [2.5.69-mm8] ide_dmaq_intr: stat=40, not expected
Date: Thu, 22 May 2003 18:30:00 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just so you know, 0x40 status indicates "queued command received, not ready
for service yet".  However, some drives we've tested internally will stay
0x40 status instead of switching back to 0x50 status once they've serviced
the last queued tag.

They will go 0x50 following a successful non-queued command however.

--eric

-----Original Message-----
From: Julien Oster [mailto:lkml@mf.frodoid.org]
Sent: Thursday, May 22, 2003 5:26 PM
To: Bartlomiej Zolnierkiewicz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69-mm8] ide_dmaq_intr: stat=40, not expected


Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

> Hello,

Hello Bartlomiej,

> Can you compile without IDE TCQ and tell whats the difference?

Uh, well.

The message disappeared. However, since keyboard and mouse still
didn't work (although all input devices are compiled in - did I miss
something?), I had to press reset again.

Now my system seems quite fucked up. (or, better: "fscked up", since
the problems appeared there...)

After rebooting (again my stable 2.4.21-rc1 kernel), fsck ate a lot of
files on the root partition, all with "unused
inode... CLEARED". Strangely, ONLY on the root filesystem. All other
filesystems (all on md devices, like the root filesystem) are perfect.

I don't know if that's still an issue of IDE TCQ, but I think I'll
quit trying it out, since I already lost X right now and have to
restore quite a few things.

Well, of course I have backups, I wouldn't install a development
kernel without expecting things that are even much worse, but all
those recompile, reboot, retry, reset and restore backup cycles are
currently a bit too time consuming :)

However, if you need additional information to track the TCQ-problem
down, I see what I can give.

Regards,
Julien
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
