Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263756AbRFDBom>; Sun, 3 Jun 2001 21:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263827AbRFDBod>; Sun, 3 Jun 2001 21:44:33 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63451 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263756AbRFDBAH>;
	Sun, 3 Jun 2001 21:00:07 -0400
Date: Mon, 4 Jun 2001 02:59:34 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106040059.CAA184232.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: mount --bind accounting
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> /* No capabilities? What if users do thousands of these? */

> look at mount_is_safe()

Yes, good. My remark means that more tests are required
than those sketched in mount_is_safe(), and that means
that for the time being we can throw out the routine
mount_is_safe(), and remove the test on capable(CAP_SYS_ADMIN)
in do_remount(), and move the same test in do_mount up to
the start: all forms of mount require CAP_SYS_ADMIN.

[side effect: remount read-only upon umount of root fs
may be possible in a few more cases]

Andries
