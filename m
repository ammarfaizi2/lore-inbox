Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277437AbRJJWR5>; Wed, 10 Oct 2001 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277440AbRJJWRr>; Wed, 10 Oct 2001 18:17:47 -0400
Received: from [213.97.199.90] ([213.97.199.90]:2944 "HELO fargo")
	by vger.kernel.org with SMTP id <S277437AbRJJWRi> convert rfc822-to-8bit;
	Wed, 10 Oct 2001 18:17:38 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Thu, 11 Oct 2001 00:15:06 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: __alloc_pages error / badblocks proccess killed
Message-ID: <Pine.LNX.4.33.0110102356550.1004-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel is 2.4.10. While doing a 'badblocks -w -s -v /dev/hdg' i've found
some errors.

badblocks first write a pattern in the disk, and after having finished
that part, it compares data actually written in the disk and checks
for errors, then it's when i get these errors, several allocation
failed messages, and VM killing first syslogd, klogd and in last place
badblocks proccess. Any idea why is this happening, are VM changes in
2.4.10 causing this ? Most of the RAM (320mb) is used by blackblocks,
but almost no swap is used.

Oct 10 23:55:50 fargo kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c0122ce7
Oct 10 23:55:50 fargo kernel: VM: killing process klogd
Oct 10 23:55:50 fargo kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c0122ce7
Oct 10 23:55:50 fargo last message repeated 2 times
Oct 10 23:55:50 fargo kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0) from c0132954
Oct 10 23:55:50 fargo kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c0122ce7
Oct 10 23:55:50 fargo kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012349e
Oct 10 23:55:50 fargo kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c0122ce7
Oct 10 23:55:50 fargo last message repeated 12 times
Oct 10 23:55:50 fargo kernel: VM: killing process badblocks




David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


