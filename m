Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbSKQWpP>; Sun, 17 Nov 2002 17:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbSKQWpP>; Sun, 17 Nov 2002 17:45:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267611AbSKQWpL>;
	Sun, 17 Nov 2002 17:45:11 -0500
Date: Sun, 17 Nov 2002 23:28:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: zap_low_mappings -- why?
Message-ID: <20021117222808.GA5228@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For S3 wakeup I need identity mappning. There's
acpi_create_identity_pmd(), but its broken: it only creates 4MB worth
on mappings, and you get really *nasty to debug* crashes if you enable
enough options in your kernel.

Question is how to fix it nicely.

I thought about killing zap_low_mappings and then reusing
swapper_pg_dir for that purpose. Is there some problem with that?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
