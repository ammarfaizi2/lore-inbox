Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRAIUdt>; Tue, 9 Jan 2001 15:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131251AbRAIUdn>; Tue, 9 Jan 2001 15:33:43 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:58549 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129774AbRAIUd0>; Tue, 9 Jan 2001 15:33:26 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Floppy disk strange behavior
Date: 09 Jan 2001 15:33:15 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3itnoihys.fsf@shookay.e-steel.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 979072328 27294 192.168.3.43 (9 Jan 2001 20:32:08 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 9 Jan 2001 20:32:08 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
	Hi!

I have switched a long time ago to linux-2.4 (and even 2.3 series) and I
have a wierd problem.
I use GRUB to boot my system. Basically, when you want to install GRUB on a
floppy disk, you do that:

dd if=stage1 of=/dev/fd0 bs=512 count=1
dd if=stage2 of=/dev/fd0 bs=512 seek=1

But since kernel 2.3.xx (I don't remember exactly), I got this error
message when I try to do the second dd (even as root):
dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied

And this thing works properly when under 2.2.xx...

I try to look a the diff of floppy.c between 2.2.18 and 2.4.0 but at this
time, I didn't find anything...
-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
