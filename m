Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLKVoR>; Mon, 11 Dec 2000 16:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbQLKVoH>; Mon, 11 Dec 2000 16:44:07 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:29197 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129387AbQLKVnz>;
	Mon, 11 Dec 2000 16:43:55 -0500
Date: Mon, 11 Dec 2000 13:14:54 -0800
From: David Hinds <dhinds@valinux.com>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: Linus Torvalds <torvalds@transmeta.com>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
Message-ID: <20001211131454.B31098@valinux.com>
In-Reply-To: <Pine.LNX.4.10.10012081319010.11626-100000@penguin.transmeta.com> <200012090541.AAA17863@tsx-prime.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <200012090541.AAA17863@tsx-prime.MIT.EDU>; from Theodore Y. Ts'o on Sat, Dec 09, 2000 at 12:41:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 12:41:24AM -0500, Theodore Y. Ts'o wrote:
> 
> There was is usual with these sorts of things, multiple problems I was
> dealing with.  The first was that I was trying to use cardmgr, and my
> pcmcia config file was still trying to load epic_cb.  Oops.  David, you
> might want to mention of this caveat in the README-2.4 file in the
> pcmcia-cs package.

I'm aware of the problem but I'm not actually sure what to present as
the appropriate solution yet; in the new scheme, cardmgr should just
ignore these cards and not load any module at all (as /sbin/hotplug 
should do that).  But I haven't decided how cardmgr will deduce that.

By the way, in my hands, PCMCIA serial cards do work ok with the 2.4
PCMCIA modules as of test12-pre7.  So I'm not sure what's going on in
Ted's situation, if the non-kernel PCMCIA is working: there should
not be much different for 16-bit cards.  I do seem to have some new
problems with Cardbus cards that I wasn't having with earlier 2.4
releases but I haven't made any attempt to figure that out yet.

-- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
