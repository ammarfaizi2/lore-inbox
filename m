Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbTLHRqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTLHRq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:46:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:50306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265521AbTLHRq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:46:27 -0500
Date: Mon, 8 Dec 2003 09:46:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <br28f2$fen$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.58.0312080939460.13236@home.osdl.org>
References: <20031207110122.GB13844@zombie.inka.de>
 <Pine.LNX.4.58.0312070812080.2057@home.osdl.org> <br28f2$fen$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, bill davidsen wrote:
> |
> | It's bad from a technical standpoint (anybody who names a generic device
> | with a flat namespace is just basically clueless), and it's bad from a
> | usability standpoint. It has _zero_ redeeming qualities.
>
> And the redeeming features of naming disks, CDs, and ide-floppy devices
> hda..hdx in an order depending on the loading order of the device
> drivers?

.. but you can fix that. Several ways. Make up your own names. Make it
have "/dev/the-cd-with-the-blue-faceplate" if you want, and it will all
still work quite intuitively.

And when you switch the hardware around, and the CD-ROM breaks and you
replace it with another one (still with a blue face-plate, just to not
confuse the user unnecessarily, but this time it ends up being on another
bus entirely), the "/dev/the-cd...-faceplate" thing still works with
minimal effort on the admin part.

And it works in _all_ situations.

Sure, you can have all programs use their own random naming scheme and use
.cdrecordrc and edit that instead, but then you have to remember to edit
the .k3drc thing too, and the /etc/fstab, and so on and so on.

Isn't it saner to use a naming scheme that everybody can agree on, and
that is generic enough that it really _does_ work for everybody, and that
allows localised names?

		Linus
