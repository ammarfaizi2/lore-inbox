Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132362AbQKZQ5c>; Sun, 26 Nov 2000 11:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132375AbQKZQ5X>; Sun, 26 Nov 2000 11:57:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24439 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S132362AbQKZQ5J>; Sun, 26 Nov 2000 11:57:09 -0500
Date: Sun, 26 Nov 2000 17:26:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread bogosity
Message-ID: <20001126172658.A5636@athlon.random>
In-Reply-To: <20001123232333.A6426@bug.ucw.cz> <20001124014830.I1461@athlon.random> <20001124205247.A141@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001124205247.A141@bug.ucw.cz>; from pavel@suse.cz on Fri, Nov 24, 2000 at 08:52:47PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 08:52:47PM +0100, Pavel Machek wrote:
> How can that work? restore_args ends with iret, anyway, and iret does
> reload esp afaics...

... only if there's an IPL change during the iret. Page 3-321 of 24319102.pdf
from Intel:

	[..] If the return is to another privilege level, the IRET instruction
	also pops the stack pointer and SS from the stack, before resuming
	program execution. [..]

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
