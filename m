Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRBGU1e>; Wed, 7 Feb 2001 15:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129812AbRBGU1O>; Wed, 7 Feb 2001 15:27:14 -0500
Received: from brauhaus.paderlinx.de ([194.122.103.4]:58358 "EHLO
	imail.paderlinx.de") by vger.kernel.org with ESMTP
	id <S129498AbRBGU1M>; Wed, 7 Feb 2001 15:27:12 -0500
Date: Wed, 7 Feb 2001 21:26:49 +0100 (MET)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: "Bigger" rsync hangs with 2.4.0, 2.4.1, 2.4.1ac4
Message-ID: <Pine.LNX.4.20.0102072115480.16259-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>




(Relevant) HW is:

MB: Serverworks HE-Chipset
RAM: 1GB
CPU: 2xPIII 933Mhz
"System"-HDD: 18GB Ultra 160SCSI
"Data"-HDD: 2xIBM DTLA 307045 plugged onto a "Promise Ultra 66"

Some "simple" steps to do that.

mount /dev/hde1 /x1
mount /dev/hdg1 /x2
(The two DTLAs)

rsync -av --delete /x1/kernel/ /x2/kernel/

"a few" files works without problems, when the rsync is "a bit" bigger
than it will hang "forever" when it did the work.

(I can "recreate" it with rsyncing "2.4.1" to "2.4.1ac4")

The rsync is "successfull". (Rerunning it works without problems. "diff
-Nur" doesn't show any differences)

Filesystem doesn't seam to matter. I had the problem with reiserfs and
ext2.


If you need more Information i will provide them. (Even remote-login is no
problem)



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
