Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJYMgm>; Thu, 25 Oct 2001 08:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRJYMgc>; Thu, 25 Oct 2001 08:36:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34319 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273204AbRJYMgY>; Thu, 25 Oct 2001 08:36:24 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 25 Oct 2001 13:42:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        linux-kernel@vger.kernel.org, mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <Pine.LNX.4.33.0110242111260.9147-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 24, 2001 09:14:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wjqP-0004kD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a acpi deamon that decides to make the machine go to sleep
> while burning a CD, that's nothign to do with the kernel at all.

One job kernel drivers have is to say "I can't safely sleep at this moment"
Even windows/XP beta gets this right.

> The kernel does not set policy. If the user says "suspend now", then we
> suspend now. Whether a CD burn or anything else is going on is totally
> irrelevant.

I know what the end user viewpoint on that would be. In a sense I do
agree with you - but that would assume we could re-invent every single
scsi generic driver, figure out how to make /proc/sg/%d/... work and the
like

> But if I say "suspend", and the kernel refuses, I will kill the offending
> piece of crap from sg.c before you can blink an eye.

Thats fine by me. Anyone wanting to be able to burn cds safely can run a
-ac kernel tree

Alan
