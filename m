Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVKMKX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVKMKX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 05:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVKMKX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 05:23:28 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:57216 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932314AbVKMKX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 05:23:27 -0500
Date: Sun, 13 Nov 2005 11:23:21 +0100
From: Martin Mares <mj@ucw.cz>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051113102321.GA1481@ucw.cz>
References: <43766AC5.9080406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43766AC5.9080406@gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Reported from Redhat Bugzilla Bug 170450
> 
> "I updated to the development kernel and now during boot only the top of the
> text is visable. For example the monitor screen the is the lines and I can
> only  see text in the asterik area.
> ---------------------
> | ****************  |
> | *              *  |
> | *              *  |
> | ****************  |
> |                   |
> |                   |
> |                   |
> ---------------------
> 
> I have a Silicon Graphics 1600sw LCD panel with a Number Nine Revolution 4
> video card."
> 
> This bug seems to be a glitch in the VGA core of this chipset.  Resizing
> the screen triggers the mentioned bug.
> 
> The workaround is to make vgacon avoid calling vgacon_doresize() if the
> display parameters did not change. It also has a nice side effect of faster
> console switches, but that will be barely noticeable.

This patch really deserves a comment in the code that such a broken hardware
exists.

Also, I don't see much reasons for introducing VGA_FONTWIDTH, it seems to only
complicate the code.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
For every complex problem, there's a solution that is simple, neat and wrong.
