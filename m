Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135935AbRDZVXR>; Thu, 26 Apr 2001 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135939AbRDZVXH>; Thu, 26 Apr 2001 17:23:07 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:10766 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135935AbRDZVWz>; Thu, 26 Apr 2001 17:22:55 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200104262113.XAA01552@kufel.dom>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: kufel!transmeta.com!torvalds@green.mif.pg.gda.pl (Linus Torvalds)
Date: Thu, 26 Apr 2001 23:13:30 +0200 (CEST)
Cc: kufel!math.psu.edu!viro@green.mif.pg.gda.pl (Alexander Viro),
        kufel!suse.de!andrea@green.mif.pg.gda.pl (Andrea Arcangeli),
        kufel!lxorguk.ukuu.org.uk!alan@green.mif.pg.gda.pl (Alan Cox),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com> from "Linus Torvalds" at kwi 26, 2001 01:08:25 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Note that I think all these arguments are fairly bogus.  Doing things like
> "dump" on a live filesystem is stupid and dangerous (in my opinion it is
> stupid and dangerous to use "dump" at _all_, but that's a whole 'nother
> discussion in itself), and there really are no valid uses for opening a
> block device that is already mounted. More importantly, I don't think
> anybody actually does.

I know a few people that often do:

dd if=/dev/hda1 of=/dev/hdc1
e2fsck /dev/hdc1

to make an "exact" copy of a currently working system.

Maybe it is stupid, but they do.
Fortunately, their systems are not SMP...

Andrzej

