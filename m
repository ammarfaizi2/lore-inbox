Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314483AbSD1UHs>; Sun, 28 Apr 2002 16:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSD1UHr>; Sun, 28 Apr 2002 16:07:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:34705 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314483AbSD1UHq>;
	Sun, 28 Apr 2002 16:07:46 -0400
Date: Sun, 28 Apr 2002 13:06:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.10+ acpi0419 breakage
Message-ID: <20020428110630.GA702@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On athlon desktop:

....
ide: unexpected interrupt 1 15
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
...
hcd.c: new USB bus registered, assigned bus number 1
[hang]

acpi=off fixes it.

On toshiba notebook, boot is broken *only after cold boot*. I can boot
successfully from warm boot.

It says 
ide: unexpected interrupt 1 15
Unable to handle NULL pointer dereference
EIP=somewhere in __ide_end_request. acpi=off does not fix this one.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
