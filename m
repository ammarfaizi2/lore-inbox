Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKDTBJ>; Sat, 4 Nov 2000 14:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDTBA>; Sat, 4 Nov 2000 14:01:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44303 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129093AbQKDTAu>;
	Sat, 4 Nov 2000 14:00:50 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011041438.OAA05656@raistlin.arm.linux.org.uk>
Subject: Re: USB init order dependencies.
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 4 Nov 2000 14:38:51 +0000 (GMT)
Cc: randy.dunlap@intel.com (Dunlap Randy),
        dwmw2@infradead.org ('David Woodhouse'), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A03C7C7.87CE750F@mandrakesoft.com> from "Jeff Garzik" at Nov 04, 2000 03:24:39 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Putting a call into init/main.c isn't a long term solution, but it
> should get us there for 2.4.x...  init/main.c is also the best solution
> for ugly cross-directory link order dependencies.  I would say the link
> order of foo.o's in linux/Makefile is the most delicate/fragile of all
> the Makefiles...  touching linux/Makefile link order this close to 2.4.0
> is asking for trouble.  Compared to that, adding a few lines to
> init/main.c isn't so bad.

There'll be quite a few extra init calls going in there then, with lots
and lots of ifdefs ;(
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
