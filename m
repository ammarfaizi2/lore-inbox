Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbRA3JtH>; Tue, 30 Jan 2001 04:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbRA3Js6>; Tue, 30 Jan 2001 04:48:58 -0500
Received: from styx.suse.cz ([195.70.145.226]:60668 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130219AbRA3Jsk>;
	Tue, 30 Jan 2001 04:48:40 -0500
Date: Tue, 30 Jan 2001 10:48:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [patch] Update of the VIA driver to version 3.20
Message-ID: <20010130104826.A1650@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The current VIA driver in 2.4.0 is version 2.1e. I wouldn't push a new
version, but VIA has released the vt82c686b chip and it's causing a lot
of trouble.

The 2.1e version can't recognize it from the vt82c686a, the only
difference being the revision of the ISA bridge. This causes quite a lot
of trouble, because the 686b chip has some significant changes in its
UDMA programming, because it can do UDMA100.

The 3.20 driver I'm sending a diff for is well tested and working
nicely, also enabling the use of UDMA100 on the vt82c686b.

On some vt82c586b's it fixes crashes and reboots, because it disables a
certain dangerous feature (hold PREQ# till DDACK# unasserted), which
BIOSes sometimes leave enabled.

It also handles 8-bit (command) timing of the ATA bus better.

I know it's a big change, but please put this patch either in 2.4.1 or
in 2.4.2 - it'll help a lot of people and I'll be getting much less
mails about non-working 686b's.

It's against 2.4.1-pre12, but should patch cleanly against pre11 or
anything later.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
