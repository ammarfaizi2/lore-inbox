Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbRA3WKs>; Tue, 30 Jan 2001 17:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132665AbRA3WKp>; Tue, 30 Jan 2001 17:10:45 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:64779 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S132622AbRA3WK2>;
	Tue, 30 Jan 2001 17:10:28 -0500
Date: Tue, 30 Jan 2001 23:10:05 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: WOL and 3c59x (3c905c-tx)
Message-ID: <Pine.LNX.4.30.0101302302080.12548-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When shutting down my computer with Linux, I cannot wake it up using
wake-on-LAN, which I can do if I shut it down from WinME or the LILO
prompt using the power button.

I see some "interesting" code in 3c59x.c and acpi_set_WOL, and there is
the following little comment: "AKPM: This kills the 905".

So, what's up?  Does it break all 905s?  And will not changing the state
to D3, as a comment a few lines down says, shut the card down, which seems
to be a bad thing to do in a function called from vortex_probe1...  I know
this code is currently bypassed, but still, what is this?

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
