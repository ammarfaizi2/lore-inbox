Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSKFU21>; Wed, 6 Nov 2002 15:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265962AbSKFU21>; Wed, 6 Nov 2002 15:28:27 -0500
Received: from h64-251-67-69.bigpipeinc.com ([64.251.67.69]:4882 "HELO
	kelownamail.packeteer.com") by vger.kernel.org with SMTP
	id <S265960AbSKFU20> convert rfc822-to-8bit; Wed, 6 Nov 2002 15:28:26 -0500
From: "Stephane Charette" <scharette@packeteer.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Date: Wed, 06 Nov 2002 12:35:04 -0800
Reply-To: "Stephane Charette" <scharette@packeteer.com>
X-Mailer: PMMail 2000 Standard (2.20.2502) For Windows 2000 (5.0.2195;2)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: kernel panic not causing a reboot!?
Message-Id: <20021106202826Z265960-32597+17098@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MY QUESTIONS ARE:

1) Why did these boxes not reboot after the kernel panic?
2) Are there 2 kinds of kernel panic?  A "mini-panic-don't-reboot" as
well as a full-out kernel panic?
3) Is the "file-max limit 4096 reached" error indicative of the reason
why the kernel for some reason couldn't reboot?

----------------------------------

DETAILS & EXPLANATION:

I have a number of 2.2.14 boxes running some custom software.  The
loadlin bootup parameters include:

   [...] panic=1

And to be extra certain, rc.local calls 'echo "1"
>/proc/sys/kernel/panic'.  I can confirm the value of "panic":

   [root@localhost /root]# cat /proc/sys/kernel/panic
   1

So all seems fine ***EXCEPT*** that recently I've observed the
following situation twice on these boxes:

   [root@localhost /root]# Kernel panic: Free list corrupted
   VFS: file-max limit 4096 reached

This box had been sitting mostly idle for a few days before I got
around to checking the console.  Doing a usenet search on "Kernel
panic: Free list corrupted" returns much information, but not much that
seems to be helpful.

The first question is why did these boxes not reboot after the kernel
panic?

Strangely enough, I found that even after this kernel panic I still had
access to the console.  However, I couldn't run anything, as evidenced
by this cut-and-paste:

   [root@localhost /root]# cat /proc/sys/kernel/panic
   bash: fork: Resource temporarily unavailable
   [root@localhost /root]# ls -la
   bash: fork: Resource temporarily unavailable

Are there 2 kinds of kernel panic?  A "mini-panic-don't-reboot" as well
as a full-out kernel panic?  Or is the "file-max limit 4096 reached"
error indicative of the reason why the kernel for some reason couldn't
reboot?

A few technical details:
- vanilla 2.2.14 kernel
- FAT fs on 1st hard disk (mounted periodically to backup some files)
- ext2 on 2nd hard disk (Linux on this drive)
- 512 MB ram
- PCnet/FAST III (pcnet32.c) ethernet

Thanks in advance for any assistance provided,

Stéphane Charette




