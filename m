Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277346AbRJJR6H>; Wed, 10 Oct 2001 13:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277344AbRJJR56>; Wed, 10 Oct 2001 13:57:58 -0400
Received: from atlante.atlas-iap.es ([194.224.1.3]:19468 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S277346AbRJJR5x>; Wed, 10 Oct 2001 13:57:53 -0400
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.11 responsiveness  and mtrr
Date: Wed, 10 Oct 2001 19:59:39 +0200
Message-ID: <LOEGIBFACGNBNCDJMJMOGEPADAAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I've trying 2.4.10 and 2.4.11. The two problems I've reported about 2.4
before don't reporduce anymore:

memory consumption:
http://www.cs.helsinki.fi/linux/linux-kernel/2001-04/1578.html

agressive swap/read once cache files (few weeks ago).

Now, after listening hours of mp3 the memory usage keeps very low and there
is no a byte swapped out (with KDE and konqueror running):


gallir@linux:~$ free
             total       used       free     shared    buffers     cached
Mem:        513620     402880     110740          0      56232     317240
-/+ buffers/cache:      29408     484212
Swap:       503992          0     503992



But, the system responsiviness is worse than before, especially in two cases
(on a PIII 1000):

- The X-mouse pointer blocks for short periods and the audio is also
interrupted when buffers are flushed to disk (using ReiserFS), it occurs
also with the X-server reniced to -15.

- mmap/blocking when reading files from the cd-driver (iso9660), very often
noticeable when starting to play a new MP3 file (I believe noatun uses
mmap). It seems a problem of mmap and/or read ahead buffers. I didn't notice
this problem in pre-2.4.10 kernels, at least no so often.


I also saw a strange errors that didn't appear before (may be related to
closed nvidia modules, if so disregard it):

...
NVRM: loading NVIDIA kernel module version 1.0-1541
mtrr: no MTRR for f0000000,2000000 found
mtrr: no MTRR for f0000000,2000000 found
mtrr: no MTRR for f0000000,2000000 found
...


--ricardo
http://m3d.uib.es/~gallir/

