Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRJNF30>; Sun, 14 Oct 2001 01:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274337AbRJNF3P>; Sun, 14 Oct 2001 01:29:15 -0400
Received: from pubnix.org ([204.80.221.10]:45952 "EHLO pubnix.org")
	by vger.kernel.org with ESMTP id <S274305AbRJNF3B>;
	Sun, 14 Oct 2001 01:29:01 -0400
Date: Sun, 14 Oct 2001 01:26:39 -0400 (EDT)
From: syzygy <syzygy@pubnix.org>
To: linux-kernel@vger.kernel.org
Subject: IDE/SCSI Lockup
In-Reply-To: <Pine.GSO.4.21.0110140103210.3903-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0110140109170.28750-100000@pubnix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use a Maxtor 27gig 92720U8 on my primary IDE channel (alone) and a TEAC
IDE 24x CD rom on the secondary channel.  I also use an Adaptec 7890/1
with a 2 ibm hard drives and a scanner,dvd,burner.  My machine hangs solid
on various occasions.  The common thread is using the IDE drive (which is
just MP3 storage)...  I have tried using hdparm -d 0 on the drive but it
still locks up.  It is very inconsistant when it locks up.  My first idea
was to try large data transfers.  I did things like write all of my memory
to disk to try and get it to lock up.  It didn't...  It seems to lock up
most under multiple simultaneous accesses.  The one repeatable killer I
found however was multiCD (a backup solution that builds an image file
from a source directory and then burns that image to CD-Rs)  I was using
it to backup the MP3s to cds.  the images were being created on my scsi
drive.  This is why I am suspicious that its the interaction of the
two.  This IS an SMP box.  The drive has also been known to cause
problems...  I experianced similar lockups on my old P166 that used to
house this drive - but they went away when I seperated it from the Quantum
Fireball that it was sharing a chain with.

I understand this might just be a hardware issue but I'd like to really
pin it on that before I go complain to Maxtor.  Not to mention the drive
is old so they will likely tell me to jump in a lake.
Kernel 2.4.7 btw...

Keith Baker	
Email:	Syzygy@pubnix.org
IM:	t3chie	
Tele:	631-786-3495

Life is a sexually transmitted disease with 100% mortality. 


