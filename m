Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbQKSUf3>; Sun, 19 Nov 2000 15:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQKSUfU>; Sun, 19 Nov 2000 15:35:20 -0500
Received: from [194.213.32.137] ([194.213.32.137]:10245 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129413AbQKSUfA>;
	Sun, 19 Nov 2000 15:35:00 -0500
Date: Sat, 18 Nov 2000 17:00:45 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test11-pre6 still very broken
Message-ID: <20001118170045.A177@toy>
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <20001117223137.A26341@wirex.com> <3A162EFE.A980A941@talontech.com> <20001117235624.B26341@wirex.com> <8v6h3d@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8v6h3d@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 18, 2000 at 10:17:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >One note for the archives, if you are presented a choice between a OHCI
> >or a UHCI controller, go for the OHCI.  It has a "cleaner" interface,
> >handles more of the logic in the silicon, and due to this provides
> >faster transfers.
> 
> I'd disagree.  UHCI has tons of advantages, not the least of which is
> [Cthat it was there first and is widely available.  If OHCI hadn't been
> done we'd have _one_ nice good USB controller implementation instead of
> fighting stupid and unnecessary battles that shouldn't have existed in
> the first place. 

UHCI has one bad disadvantage: the way it is designed, you can choose
either slow USB or slow system.

If you are doing bulk usb transfers at high speed (faster than ISDN modem,
or so), you need to make loop in the command "tree", which hogs down your
PCI bus (leading to slow overall performance). It is called FSBR and its
ugly. 50% system slowdown due to stupid UHCI.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
