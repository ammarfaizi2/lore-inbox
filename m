Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754347AbWKMJpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbWKMJpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbWKMJpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:45:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43225 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1754344AbWKMJpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:45:23 -0500
Date: Mon, 13 Nov 2006 10:45:22 +0100
From: Martin Mares <mj@ucw.cz>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Message-ID: <mj+md-20061113.094333.4571.atrey@ucw.cz>
References: <1163374762.5178.285.camel@gullible> <1163378981.2801.3.camel@entropy> <1163381067.5178.301.camel@gullible> <1163382425.2801.6.camel@entropy> <1163395364.5178.327.camel@gullible> <1163400313.2801.11.camel@entropy> <1163401845.5178.335.camel@gullible>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163401845.5178.335.camel@gullible>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> No, in a lot of cases, it's not a deficiency. Take the entire
> drivers/ata/pata_*.ko list. All of them match an IDE driver, however the
> pata driver most times does not support all the same PCI id's for the
> matching ide driver.
> 
> Also the other case I gave where there is an alsa driver and a media
> driver for the same chipset, is by design. It can't be helped. There
> actually is a case for wanting one driver or the other in the case of
> the exact same hardware, depending on the users desire.

If you have two drivers for the same device, there is no problem --
just insmod one of the drivers. The ugly cases are the "a b / b c"
described in the first mail of this thread -- however, are these really
sane? Shouldn't they be split to multiple drivers?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A bug in the code is worth two in the documentation.
