Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129316AbQJZWv5>; Thu, 26 Oct 2000 18:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbQJZWvr>; Thu, 26 Oct 2000 18:51:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13072 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129774AbQJZWvi>;
	Thu, 26 Oct 2000 18:51:38 -0400
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200010262004.e9QK4wJ21270@flint.arm.linux.org.uk>
Subject: Re: [PATCH] make my life easier ...
To: andre@linux-ide.org (Andre Hedrick)
Date: Thu, 26 Oct 2000 20:04:56 +0000 ()
Cc: sfr@linuxcare.com.au (Stephen Rothwell),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox), mlord@pobox.com (Mark Lord)
In-Reply-To: <Pine.LNX.4.10.10010252040250.6326-100000@master.linux-ide.org> from "Andre Hedrick" at Oct 25, 2000 09:25:10 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick writes:
> APM signals ATA/IDE to goto sleep.
> IDE then records and buffers the setup of the host and device.
> IDE forces device and host to PIO 0 (imortant step, explain later)
> IDE issues spindown and sleep task-command.
> IDE returns to APM with success/failure.

Insert here... BIOS tries to hibernate to disk and finds the disk already
asleep.

> 	success, sets request_queue blocker flag (very critical)
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
