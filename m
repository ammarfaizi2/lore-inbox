Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270808AbTHJXkI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHJXkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:40:08 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:44184 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270808AbTHJXkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:40:05 -0400
Date: Mon, 11 Aug 2003 01:39:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sander ten Broek <sander@telefabel.cjb.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use EDID/DDC data to set better refreshrates on VBE3.0+ videocards on boot
Message-ID: <20030810233949.GA3898@elf.ucw.cz>
References: <3F2DAD6D.2010605@telefabel.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2DAD6D.2010605@telefabel.cjb.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 
> The following patch requests EDID data from the monitor/graphics card, 
> check it against the vga= setting the user set and when it finds a match 
> sets the refresh rate to the EDID supplied mode (So should be safe, even 
> on broken biosses). This makes working in vesafb mode _allot_ better for 
> your eyes. If either no vesa 3.0 card or VBE/DC EDID data is available 
> it just sets the vesa graphic mode the old tried and tested way (60Hz ugh!).
> 
> I have tested the patch on the following cards with different feature 
> support (All same type monitor though):
> 
> - Geforce2 MX/MX 400: Working at 85hz
> - Geforce 256 SDR: Working at 85Hz
> - GeForce2 - nForce GPU: Not working, no EDID data available
> - VMWare v4: Not working, not a VBE v3.00 card
> 
> Not working, in this case, means that it just used normal 60hz vesa 
> mode. The graphic mode was otherwise working fine.
> 
> What do you think? :)

This is really needed for vesafb to be usefull on non-LCD displays...

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
