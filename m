Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWAPN60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWAPN60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWAPN6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:58:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24252 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750764AbWAPN6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:58:25 -0500
Date: Mon, 16 Jan 2006 12:40:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>, seife@suse.de
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend to RAM and disk
Message-ID: <20060116114037.GA26986@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In good old days of Pentium MMX, when ACPI was not yet born and APM
ruled the world, I had and thinkpad 560X notebook. And that beast
supported suspend-to-both: It stored image on disk, but then suspended
to RAM, anyway. I think I want that feature back.

[Advantage was, that suspend/resume was reasonably fast for common
case, yet you did not loose your opened applications if your battery
ran flat. Speed advantage will be even greater these days -- boot of
"resume" kernel takes most of time.]

Unfortunately, suspend-to-RAM is not in quite good state these
days. It tends to work -- after you setup your video drivers according
to video.txt, with some scripting needed. Unfortunately, after we
suspended to disk, system is frozen -- we may not run scripts.

I guess the solution is to create userland application that will parse
the DMI, look into table, and if it is neccessary do the vbe
saving/restoring itself. (We may not run external binaries on frozen
system; everything has to be pagelocked.) I guess that will include
quite a lot of cut-copy-and-paste from various project, but I see no
other way :-(.

OTOH this should get us to state where suspend-to-RAM "just works", so
I guess it is worth it.
								Pavel 
-- 
Thanks, Sharp!
