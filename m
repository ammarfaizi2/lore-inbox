Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280999AbRKGVQO>; Wed, 7 Nov 2001 16:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280989AbRKGVPD>; Wed, 7 Nov 2001 16:15:03 -0500
Received: from mrelay.cc.umr.edu ([131.151.1.89]:25605 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S280996AbRKGVNx>;
	Wed, 7 Nov 2001 16:13:53 -0500
Message-ID: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu>
From: "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>
To: "'H. Peter Anvin'" <hpa@zytor.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Yet another design for /proc. Or actually /kernel.
Date: Wed, 7 Nov 2001 15:13:25 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: H. Peter Anvin [mailto:hpa@zytor.com]
>Sent: Wednesday, November 07, 2001 2:58 PM
>To: linux-kernel@vger.kernel.org
>Subject: Re: Yet another design for /proc. Or actually /kernel.


>Followup to:  <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
>By author:    spamtrap@use.reply-to (Erik Hensema)
>In newsgroup: linux.dev.kernel
>> 
>> - Multiple values per file when needed
>> 	A file is a two dimensional array: it has lines and every line
>> 	can consist of multiple fields.
>> 	A good example of this is the current /proc/mounts.
>> 	This can be parsed very easily in all languages.
>> 	No need for single-value files, that's oversimplification.
>> 

>Actually, /proc/mounts is currently broken, and is an excellent
>example of why the above statement simply isn't true unless you apply
>another level of indirection: try mounting something on a directory
>the name of which contains whitespace in any form (remember, depending
>on your setup this may be doable by an unprivileged user...)

>	-hpa


mbrennek@spaceheater:/home/mbrennek# mkdir stuff\ and
mbrennek@spaceheater:/home/mbrennek# mount -t vfat /dev/hda1
/home/mbrennek/stuff\ and/
mbrennek@spaceheater:/home/mbrennek# cat /proc/mounts
/dev/ide/host0/bus0/target1/lun0/part1 / reiserfs rw 0 0
/dev/hdb2 /home reisferfs rw 0 0
none /dev/pts devpts rw 0 0
non /proc proc rw 0 0
/dev/hda5 /mnt/stuff vfat rw,nosuid,nodev,noexec 0 0
/dev/hda1 /home/mbrennek/stuff\040and vfat rw 0 0
mbrennek@spaceheater:/home/mbrennek#

Are you refering to the 040?

-Matt
