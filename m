Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSEVVVy>; Wed, 22 May 2002 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSEVVVq>; Wed, 22 May 2002 17:21:46 -0400
Received: from h-64-105-35-18.SNVACAID.covad.net ([64.105.35.18]:58760 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314458AbSEVVUU>; Wed, 22 May 2002 17:20:20 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 22 May 2002 14:20:15 -0700
Message-Id: <200205222120.OAA06088@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Floppy corruption under Linux 2.5.15 - 2.5.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under Linux 2.5.17, if I do

		dd if=a_1.44mb_floppy_image of=/dev/floppy/0

	on a newly inserted floppy, I will get "read only filesystem"
error (the write protect tab is not open).  If I then read some data from
the floppy and try the command again, the dd succeeds the second time
with no errors, and there is enough floppy disk activity to convince
me that a full disk image may have been written, but the image is
incorrect.  I have also reproduced this problem under 2.5.15.  I have
tried on two different floppy drives.  I have tried booting from the
floppy using the same drive with which I wrote the floppy, and booting
from a different floppy drive.  It does not appear to be a hardware
problem with the drive.  I will probably get to the bottom of this
in a few days in nobody beats me to it, but I thought I ought to
pass this information along in the meantime.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
