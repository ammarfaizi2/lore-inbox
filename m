Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRB1QPv>; Wed, 28 Feb 2001 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRB1QPl>; Wed, 28 Feb 2001 11:15:41 -0500
Received: from mail.ask.ne.jp ([203.179.96.3]:54741 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S130241AbRB1QP2>;
	Wed, 28 Feb 2001 11:15:28 -0500
Date: Thu, 1 Mar 2001 01:08:59 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Wouter Schoot <wschoot@dds.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AC6 crash
Message-Id: <20010301010859.406954b1.bruce@ask.ne.jp>
In-Reply-To: <Pine.LNX.4.33.0102281617410.633-100000@wit393115.student.utwente.nl>
In-Reply-To: <Pine.LNX.4.33.0102281617410.633-100000@wit393115.student.utwente.nl>
X-Mailer: Sylpheed version 0.4.61 (GTK+ 1.2.6; Linux 2.2.18; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001 16:19:02 +0100 (CET)
Wouter Schoot <wschoot@dds.nl> wrote:

> Hello,
> 
> I entered make menuconfig with 2.4.2 patched with AC6.
> I run 2.4.2 AC2 at the moment, and unpacked 2.4.2 and AC6 from the
> scratch
> 
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
[SNIP]

Just a couple of things - when sending mail to l-k, it's probably better
to give it an accurate subject. "AC6 crash" sounds like 2.4.2ac6 crashed
while you were running it; something like "ac6 menuconfig failure" would
have been better.
The other point is, this problem has already popped up at least three
times in the last couple of days (maybe more, I'm not keeping track). A
solution has also been posted multiple times. Before posting, you might
want to check one of the l-k archives (just do a search at
http://www.google.com/ - several should be at the top of the list).
Some of them are updated in almost real-time, so even very recent
questions will appear.

Anyway, the answer to your problem is:

--- 2.9/arch/i386/config.in Wed, 28 Feb 2001 12:44:01 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.1.2 644)
+++ 2.9(w)/arch/i386/config.in Wed, 28 Feb 2001 12:46:03 +1100 kaos (linux-2.4/T/c/36_config.in 1.1.2.1.1.2 644)
@@ -379,6 +379,6 @@ bool '  Memory mapped I/O debugging' CON
 bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
-endmenu
-
 fi
+
+endmenu

This is a patch from Keith Owens. Alternatively, there appears to be an
incremental patch from ac5 up at:

http://www.bzimage.org/kernel-patches/v2.4/alan/v2.4.2/patch-2.4.2-ac5-ac6.bz2

which also fixes the EXTRAVERSION problem (it's still at ac5).

--
Bruce Harada
bruce@ask.ne.jp

