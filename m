Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130115AbQKUXss>; Tue, 21 Nov 2000 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131181AbQKUXsi>; Tue, 21 Nov 2000 18:48:38 -0500
Received: from jalon.able.es ([212.97.163.2]:49397 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130115AbQKUXsX>;
	Tue, 21 Nov 2000 18:48:23 -0500
Date: Wed, 22 Nov 2000 00:18:13 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001122001813.A1356@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001121235529.E925@werewolf.able.es> <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0011212300590.950-100000@penguin.homenet>; from tigran@veritas.com on Wed, Nov 22, 2000 at 00:04:53 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2000 00:04:53 Tigran Aivazian wrote:
> On Tue, 21 Nov 2000, J . A . Magallon wrote:
> 
> Quite the contrary. The patch seems correct and useful to me. What do you
> think is wrong with it? (Linus accepted megabytes worth of the above in
> the past...)
> 

Sorry, i should look at the rest of the code. Seeing only that, is seems like
that variables have to hold an initial value of zero, and the patch relies
on the ANSI behaviour of the compiler that auto-initializes them to 0.
I have seen many compilers break ANSI rules in optimized mode. Typical
runs-fine-in-debug-mode-but-breaks-on-production-release.
One other point for info would be gcc specs.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre22-vm #7 SMP Sun Nov 19 03:29:20 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
