Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136934AbRATAdu>; Fri, 19 Jan 2001 19:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136993AbRATAdl>; Fri, 19 Jan 2001 19:33:41 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:34810 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S136934AbRATAdX>; Fri, 19 Jan 2001 19:33:23 -0500
Message-ID: <3A68DCD1.FACB4135@voicenet.com>
Date: Fri, 19 Jan 2001 19:33:21 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Via apollo KX133 ide bug in 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry I can't be more descriptive than that, but there aren't any
errors ever displayed.  What happened was after about a day of uptime, I
began seeing IO errors when trying to access files.  I realized that the
IO errors occurred on any file I had created.  I rebooted since the
computer became impossible to use and fsck removed everything that I had
created since upgrading to the release kernel.  This is all on ext2fs.
I tried making bootdisks but they all showed up as being bad.  I tried
copying files to another ext2fs but upon fsck, they too were all removed
due to corruption.  These ext2fs' were not created by the release
kernel.  I had to go back to 2.4.0-test11 before the kernel would write
to the fs correctly.  For the record, I disabled DMA in the kernel and
i'm compiling for athlon using gcc 2.95.3.  I saw the same thing happen
though when I booted for a kernel compiled for Pentium 2.    Since
reverting back to 2.4.0-test11, however, no FS corruption has been
observed.  Anyone have any idea what this is about?  i'm compiling with
the same options between kernels but 2.4.x (release and newer) do not
seem to be able to write to the ext2fs correctly.  Could this be because
it was formatted by a 2.2.x kernel?   Anyone using this chipset I would
caution to have backups ready when using it with 2.4.x, as I lost
hundreds of files to it.  Also, no errors were reported anywhere,  IO
errors when trying to stat dirs just started appearing after a couple
days uptime ...then they would occur whenever you wrote to the FS.  Even
after a reboot.    If you need any extra iinfo about kernel options and
computer config, just ask.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
