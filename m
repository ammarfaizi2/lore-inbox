Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQKFVS1>; Mon, 6 Nov 2000 16:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbQKFVSS>; Mon, 6 Nov 2000 16:18:18 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129999AbQKFVSD>;
	Mon, 6 Nov 2000 16:18:03 -0500
Message-ID: <20001106094307.B128@bug.ucw.cz>
Date: Mon, 6 Nov 2000 09:43:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <akale@veritas.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Translation Filesystem
In-Reply-To: <3A0109D6.4DFA2F62@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A0109D6.4DFA2F62@veritas.com>; from Amit S. Kale on Thu, Nov 02, 2000 at 11:59:42AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have started a new virtual filesystem project, Translation Filesystem
> at
> http://trfs.sourceforge.net/  Description of the project is given below.
> 
> It's still at a concept stage. If someone has any ideas about any useful
> translators that fit in this framework please write to me.
> Any feedback is most welcome.

Well, take a look at uservfs.sourceforge.net (used to be called
podfuk) and probably avfs.

We are doing things like tarfs using CODA and userspace servers --
that has big advantages on not crashing machines, plus being portable
(currently Linux and Solaris). [Do not try podfuk on latest kernels:
something went wrong. 2.4.0-test5 should be okay].

Here's example session:

pavel@Elf:/$ cd "/tmp/unarj241a.tar.gz#utar/unarj241a"/
pavel@Elf:/tmp/unarj241a.tar.gz#utar/unarj241a$ ls
Makefile       os2unarj.mak   tccunarj.mak   unarj.doc
Makefile.orig  patch241a      technote.doc   unarj.exe
decode.c       qclunarj.mak   unarj.c        unarj.h
environ.c      readme.doc     unarj.def      unarj.h.orig
pavel@Elf:/tmp/unarj241a.tar.gz#utar/unarj241a$ cd /tmp
pavel@Elf:/tmp$ head mc.diff.gz#ugz
--- /dev/null   Sun Jun  2 15:30:20 1996
+++ mmc/vfs/shared.c    Mon Mar 30 23:41:55 1998
@@ -0,0 +1,267 @@
+/*
...

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
