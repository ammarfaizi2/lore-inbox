Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSF3Kxo>; Sun, 30 Jun 2002 06:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSF3Kxn>; Sun, 30 Jun 2002 06:53:43 -0400
Received: from [193.14.93.89] ([193.14.93.89]:30212 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S314707AbSF3Kxn>;
	Sun, 30 Jun 2002 06:53:43 -0400
From: Christer Weinigel <wingel@nano-system.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't find watchdog timer (sc1200)
References: <200206271803.11350.roy@karlsbakk.net>
Date: 30 Jun 2002 12:56:04 +0200
In-Reply-To: Roy Sigurd Karlsbakk's message of "Thu, 27 Jun 2002 18:03:11 +0200"
Message-ID: <m36601827v.fsf@acolyte.hack.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:

> I can't make linux (2.4.19-rc1) detect the watchdog timer in the sc1200. Any 
> ideas? 

http://basselope.nano-system.com/~wingel/scx200_wdt.diff

I'm not all that sure if that driver works on the sc1200 because that
driver tries to talk to the watchdog in the SuperI/O chip and that
chip has another watchdog circuit too.  I've written a driver for the
other watchdog chip, so if you can, please try this patch against a
2.4.9-pre10 kernel:

   http://basselope.nano-system.com/~wingel/scx200_wdt.diff

This patch is a part of my patches for the NatSemi SCx200 family of
chips, so I hope I haven't missed anything.  If it works for you,
please drop me a mail and I'll try to get it included in the main
kernel.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
