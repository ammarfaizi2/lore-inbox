Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbQKRCOY>; Fri, 17 Nov 2000 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQKRCON>; Fri, 17 Nov 2000 21:14:13 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:6664 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130516AbQKRCN7>; Fri, 17 Nov 2000 21:13:59 -0500
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu>
	<20001116150704.A883@emma1.emma.line.org>
	<20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com>
	<20001117003000.B2918@wire.cadcamlab.org>
X-Emacs: because you deserve a brk today.
From: Nix <nix@esperi.demon.co.uk>
Date: 18 Nov 2000 01:38:58 +0000
In-Reply-To: Peter Samuelson's message of "17 Nov 2000 10:25:25 -0000"
Message-ID: <87g0kq3vpp.fsf@loki.wkstn.nix>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org> writes:

> Two easy "get out of jail free" cards.  There are other, more complex
> exploits.  You have added one more.  They all require root privileges.

Unless I'm missing something, not all of them do. I haven't checked this
or anything, but it seems to me that all you need is a cooperating
process outside the jail, that opens some world-readable directory and
sends it to the exploit process inside the jail, which fchdir()s to
it. Of course you *do* need an AF_UNIX socket inside the jail for this,
too, so it is probably a quite unlikely attack; but if, for instance,
you reused an outside-the-jail uid *inside* the jail, and the jail had
places writable by this user... bing, no root necessary.

-- 
`The phrase `causes storage to be reserved', doesn't mean that it causes
 storage to be reserved.  This is a fundamental misunderstanding of
 Standardeze.' --- Mike Stump on the GCC list
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
