Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSFBNzF>; Sun, 2 Jun 2002 09:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317183AbSFBNzE>; Sun, 2 Jun 2002 09:55:04 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:10770 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317182AbSFBNzE>; Sun, 2 Jun 2002 09:55:04 -0400
Date: Sun, 2 Jun 2002 15:55:01 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Need help tracing regular write activity in 5 s interval
Message-ID: <20020602135501.GA2548@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using some recent Linux 2.4.x version (2.4.19-pre8-ac5 for now),
and I have been observing regular disk activity at 5 s intervals for
some time now which are not related to a particular kernel version.

I have reiserfs and ext3fs file systems mounted.

The first thing that came to mind with the "5 s interval" was DJB's
"svscan", but neither mount -o remount,noatime / nor killall -STOP
svscan helped.

The next thing that comes to mind is that journalling file systems
commit their journal every five seconds. But I have a hard time finding
out which file system does this or which process causes blocks to be
marked dirty again. I'd really like to get rid of this regular activity
unless there's a need.

So: is there any trace software that can tell me "at 15:52:43.012345,
process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
detail so I can figure if it's just an atime update -- as with svscan --
or a write access)? And that is NOT to be attached to a specific process
(hint: strace is not an option).

Also, I'd like to suggest again a mount option that marks filesystems as
"clean" automatically after all changes have been committed. This may be
most useful with "noatime", though.

Thanks in advance,

-- 
Matthias Andree
