Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135264AbREACl1>; Mon, 30 Apr 2001 22:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135609AbREAClR>; Mon, 30 Apr 2001 22:41:17 -0400
Received: from marine.sonic.net ([208.201.224.37]:7472 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S135264AbREACk7>;
	Mon, 30 Apr 2001 22:40:59 -0400
Message-ID: <20010430194009.A16921@sonic.net>
Date: Mon, 30 Apr 2001 19:40:09 -0700
From: David Hinds <dhinds@sonic.net>
To: linux-kernel@vger.kernel.org
Cc: Evan Montgomery-Recht <evanrecht@yahoo.com>
Subject: Re: Cardbus conflicts...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> exclude port 0x2f8-0x2ff

This exclusion is to block out the port range used by the IBM MWave
DSP chip; this is your modem, not your sound card.  Whatever your
sound problem is, I don't think it is related to this specific item.

I would recommend going to the linux-laptops site and checking out the
pages devoted to the IBM TP 600E; it is likely that for a common model
like this, people have put together detailed recipies for how to get
sound, pcmcia, etc working.

As for your specific questions, there are several better ways of
handling this sort of thing automatically.  If you build the PCMCIA
drives with "PnP BIOS support" enabled, they will discover this and
any other resource conflicts automatically.  I think this option is
also available in the newest 2.4.X kernels.  PnP BIOS support is not
enabled by default because there are compatibility problems on some
systems.  In the longer term ACPI support should also be able to
handle this sort of conflict detection but I don't think it is
sufficiently mature at this stage.

-- Dave Hinds
