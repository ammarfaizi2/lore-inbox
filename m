Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBFW6x>; Tue, 6 Feb 2001 17:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBFW6o>; Tue, 6 Feb 2001 17:58:44 -0500
Received: from THUNK.ORG ([216.175.175.175]:2056 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S129130AbRBFW6e>;
	Tue, 6 Feb 2001 17:58:34 -0500
Date: Tue, 6 Feb 2001 17:58:28 -0500
From: "Theodore Ts'o" <tytso@thunk.org>
Message-Id: <200102062258.RAA25321@thunk.org>
To: edschulz@agere.com
CC: mike@flyn.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A807C98.C5DE2C67@agere.com> (message from Ed Schulz on Tue, 06
	Feb 2001 17:37:12 -0500)
Subject: Re: Lucent Microelectronics Venus Modem, serial 5.05, and Linux 2.4.0
Phone: (781) 391-3464
In-Reply-To: <20010114201045.A1787@dragon.flyn.org> <200102061939.OAA24337@thunk.org> <3A807C98.C5DE2C67@agere.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 06 Feb 2001 17:37:12 -0500
   From: Ed Schulz <edschulz@agere.com>

   One editorial correction: Our PCI host-controller modem is based on the
   Mars DSP1646 or 1648, not the Venus DSP1673.  Venus modems include the
   controller function, so require no special Linux code to work.

Well, I've received reports that the UART in the Venus chipset may not
be behaving as a standard UART (i.e., it's not acting as a fully
16550-compatible UART should) which is causing the Linux serial code to
fail the "is-there-a-real-UART-here-or-should-I-refuse-to-touch-unknown-
I/O-ports-which-might-format-hard-drives-or-do-other-nasty-things" test.

   I'll forward these notes along to our developers, and let you know the
   result.

If your developers can tell try testing one of these modems under Linux
2.4, that would be great.  Although I don't have one of these boards,
the symptoms that people are sending me sure make it sound like a
hardware bug (or a UART emulation failure, in any case....)

Note that all the test code is doing is writing 0x0f to the UART's IER
register, and trying to read it back.  If the UART is failing this test,
it's pretty buggy.....

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
