Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316108AbSENWr0>; Tue, 14 May 2002 18:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316109AbSENWrZ>; Tue, 14 May 2002 18:47:25 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:25606 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S316108AbSENWrZ>;
	Tue, 14 May 2002 18:47:25 -0400
Message-ID: <001d01c1fb99$51eb55b0$0201a8c0@witek>
From: "Witek Krecicki" <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: [BUG 2.5.X] Hollow processes
Date: Wed, 15 May 2002 00:47:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ----- Original Message -----
From: "Manfred Spraul" <manfred@colorfullife.com>
> Witek Krecicki wrote:
> > but poldek issue on 2.5.11/12
> > was reproductible.
>
> Then please try to reproduce it with 2.5.11/12 and start SysRQ+showTasks.
I've reproduced it on 2.5.14 while building glibc.spec. Tried using
alt-sysRq-T combination but it was only showing the request, nothing was
done after it. Note that this combination was working before hang (checked
it). Also if it might be helpful: this is part of strace ls /proc/1234 where
1234 is a pid of hanged process:
getdents64(3, /* 14 entries */, 1024) = 376
lstat64(0xbffffbc0, 0x8055a64) = 0
lstat64(0xbffffbc0, 0x8055ad8) = 0
lstat64(0xbffffbc0, 0x8055b4c) = 0
lstat64(0xbffffbc0, 0x8055bc0) = 0
lstat64(0xbffffbc0, 0x8055c34) = 0
lstat64(0xbffffbc0, 0x8055ca8) = 0
lstat64(0xbffffbc0, 0x8055d1c) = 0
lstat64(0xbffffbc0, 0x8055d90) = 0
lstat64(0xbffffbc0, 0x8055e04) = 0
lstat64(0xbffffbc0, 0x8055e78) = 0
lstat64(0xbffffbc0, 0x8055eec) = 0
readlink("cwd", "/home/users/adasi/rpm/BUILD/glibc-2.2.4/localedata", 4096)
= 50
lstat64(0xbffffbc0, 0x8055f60) = 0
readlink("root", "/", 4096) = 1
lstat64(0xbffffbc0, 0x8055fd4) = 0
readlink("exe",
And from now on it's hanged :/
WK



