Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbRAWJSY>; Tue, 23 Jan 2001 04:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAWJQB>; Tue, 23 Jan 2001 04:16:01 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:12804 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129704AbRAWIir>;
	Tue, 23 Jan 2001 03:38:47 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Is this kernel related (signal 11)?
Date: Tue, 23 Jan 2001 17:37:46 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGKEMACNAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <3A6CF0C7.E0D836E3@linux.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the info, comments below:

First, I ran X in gdb and got the following via 'bt' after X died. This is
my first experience with gdb so if I should do anything in particular,
please tell me.

#0  0x401addeb in __sigsuspend (set=0xbffff930)
    at ../sysdeps/unix/sysv/linux/sigsuspend.c:48
#1  0x80495a4 in startServer ()
#2  0x804922c in main ()
#3  0x401a79cb in __libc_start_main (main=0x8048ee0 <main>, argc=5,
    argv=0xbffffacc, init=0x8048a64 <_init>, fini=0x8049a44 <_fini>,
    rtld_fini=0x4000ae60 <_dl_fini>, stack_end=0xbffffac4)
    at ../sysdeps/generic/libc-start.c:92


> David Ford:
>
> Upgrade -past- 2.2, get 2.2.1.  2.2 causes numerous segfaults,
> notably sendmail
> and apache stop working.

I'm willing. Are there any good how-tos on doing this without killing your
system? The last time I manually upgraded libc was about 5 years ago.


> Russell King:
>
>
> In answer to the original posters question, the first step would be
> to grab a copy of memtest86 (iirc its a program that is run from floppy
> disk) and run that on your system.  That /should/ (and I stress should
> there) detect any RAM problems you have.

I'll try this.



> Barry K. Nathan:
>
>
> Does it always happen when you are moving the mouse over a button or
> windowbar or some other on-screen object like that?

Nope. If anything I'd say it happens during blitting (scrolling, screen
refreshing, etc). Also, I'm not overclocking anything.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
