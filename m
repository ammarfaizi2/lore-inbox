Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbREQCLS>; Wed, 16 May 2001 22:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbREQCLI>; Wed, 16 May 2001 22:11:08 -0400
Received: from smtp-server.maine.rr.com ([204.210.65.66]:15255 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S262172AbREQCLA>; Wed, 16 May 2001 22:11:00 -0400
From: "Richard Bratt" <rbratt@home.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Hard freezes copying from (but not to) a 80GB Maxtor HD on a HPT370 channel
Date: Wed, 16 May 2001 22:09:16 -0400
Message-ID: <NBBBJCNNDBOMFPPPPDOEIEOJOMAA.rbratt@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been happily accumulating some files on an 80GB Maxtor HD sitting on
/dev/hdg mounted as /arc.  There are 2 other drives on the HPT370 (KA7-100
MB with TY Bios) and 2 on the main mother board IDE controller.  The system
is currently running 2.4.3-ac14.  It has been solid as a rock and I have
experienced no disk problems.  I don't think I have crashed in the past 4
months running a ever changing series of kernels and changing HW from time
to time.

Today I tried to cp a directory from /arc to /fs2, a file system on hde, the
primary channel of the HPT370.  The system immediately (almost, a few files
were copied) froze solid.  I have tried to get to the bottom of this and
have determined that I can copy a 2GB test directory to every drive in the
system.  At first I thought that I could copy safely off /arc if it went to
a drive not on the HPT370 controller.  Trying to copy to a test directory to
/fs (/dev/hdb) worked and copying it to /fs2 (/dev/hde) caused an almost
immediate freeze. However, when I tried to cp 10GB from /arc to /fs while a
tape backup (of a partition on /dev/hda) was going on it once again (almost)
immediately froze the system solid.

The problem seems to only relate to the 80GB Maxtor.  However, I haven't yet
done quite enough experiments to conclude that (gotta get real work done on
the machine so the reboots forced by the freezes limit how many tests I can
squeeze in in a day <G>)  I can apparently copy data to the drive to beat
the band and I have regularly accessed files on the drive (e.g., to play an
mp3) but something about a mass copy is fatal.  I consed up a 2.4.4-ac9
kernel and verified that the problem persists in that kernel too.

Can someone point me in the right direction?  I have been assuming that it
is some driver issue, but that is just an assumption.  Could it be the
drive?  It is pretty new (a few months old).  Unfortunately I must leave
town for a while in a few days.  I'd love to get on top of this before I go
if possible.

I'd appreciate any hints or similar data other could provide.

TIA,
Dick


