Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQKCK4a>; Fri, 3 Nov 2000 05:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbQKCK4U>; Fri, 3 Nov 2000 05:56:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12302 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129042AbQKCK4B>;
	Fri, 3 Nov 2000 05:56:01 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011031038.eA3Accj30162@flint.arm.linux.org.uk>
Subject: Re: USB init order dependencies.
To: randy.dunlap@intel.com (Dunlap, Randy)
Date: Fri, 3 Nov 2000 10:38:38 +0000 (GMT)
Cc: dwmw2@infradead.org ('David Woodhouse'), torvalds@transmeta.com,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDBC8@orsmsx31.jf.intel.com> from "Dunlap, Randy" at Oct 31, 2000 10:10:49 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunlap, Randy writes:
> David is entitled to his opinion (IMO).
> And I dislike this patch, as he and I have already discussed.
> 
> Short of fixing the link order, I like Jeff's suggestion
> better (if it actually works, that is):  go back to the
> way it was a few months ago by calling usb_init()
> from init/main.c and making the module_init(usb_init);
> in usb.c conditional (#ifdef MODULE).

However, that breaks the OHCI driver on ARM.  Unless we're going to start
putting init calls back into init/main.c so that we can guarantee the order
of init calls which Linus will not like, you will end up with a lot of ARM
guys complaining.

Linus, your opinion would be helpful at this point.
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
