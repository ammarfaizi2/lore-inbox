Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbQKEO3x>; Sun, 5 Nov 2000 09:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbQKEO3o>; Sun, 5 Nov 2000 09:29:44 -0500
Received: from deviant.impure.org.uk ([195.82.99.252]:48394 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S129351AbQKEO30>; Sun, 5 Nov 2000 09:29:26 -0500
To: linux-kernel@vger.kernel.org
Date: 5 Nov 2000 14:26:59 GMT
From: newsgate@impure.org.uk (Rob Andrews)
Message-ID: <slrn90arhj.ne3.rob@deviant.impure.org.uk>
Organization: The Source of all Flarg
Subject: IDE (hpt370) and DMA mode switching (again)...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote about a week or so ago about switching DMA modes on the HPT370
controller.

I've been fiddling and have found something odd.

If I compile a kernel without the 'HPT370' option in the IDE/ATA config,
the machine starts okay, and after turning DMA on, the drive fetches about
21.5MB/s. hdparm tells me the drive/chipset is in udma4. I can change the
DMA mode without crashing, although if I change out of udma4, I can't set
it back to udma3/udma4 (states that the mode is not functional).

If I compile a kernel /with/ the 'HPT370' option in the IDE/ATA config, the
machine starts okay, turns DMA mode on itself, and puts the drive into
udma2. The drive fetches 17.4MB/s. If I change DMA mode, the machine crashes.
No kernel panic, nothing - just completely dead.

Any ideas?

-- 
Rob                                 off list/ng replies: rob@impure.org.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
