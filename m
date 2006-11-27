Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758062AbWK0LfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062AbWK0LfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbWK0LfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:35:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47583 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1758062AbWK0LfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:35:19 -0500
Date: Mon, 27 Nov 2006 12:35:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Eric Sandall <eric@sandall.us>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: suspend broken in 2.6.18.1
Message-ID: <20061127113501.GC14416@elf.ucw.cz>
References: <45144C61.5020104@sandall.us> <20060923110954.GD20778@elf.ucw.cz> <453406F0.5020803@sandall.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453406F0.5020803@sandall.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-10-16 15:25:52, Eric Sandall wrote:
> Pavel Machek wrote:
> > Hi!
> > 
> >> After updating from 2.6.17.13 to 2.6.18 (using `make oldconfig`),
> >> suspend no longer suspends my laptop (Dell Inspiron 5100).
> >>
> >> # s2ram -f
> >> Switching from vt7 to vt1
> >> s2ram_do: Invalid argument
> >> switching back to vt7
> >>
> >> The screen blanks, but then comes back up after a few seconds. This
> >> happens both with and without X running.
> >>
> >> I've attached the output of `lspci -vvv` and my
> >> /usr/src/linux-2.6.18/.config for more information. Please let me know
> >> if there are any patches to try or if more information is required.
> > 
> > Relevant part of dmesg after failed attempt is neccessary... and you
> > can probably read it yourself and figure what is wrong. I'd guess some
> > device just failed to suspend... rmmod it.
> 
> (This is now with 2.6.18.1)
> 
> Stopping tasks: =====================================================|
> ACPI: PCI interrupt for device 0000:02:04.0 disabled
> ACPI: PCI interrupt for device 0000:00:1f.5 disabled
> ACPI: PCI interrupt for device 0000:00:1d.7 disabled
> ACPI: PCI interrupt for device 0000:00:1d.2 disabled
> ACPI: PCI interrupt for device 0000:00:1d.1 disabled
> ACPI: PCI interrupt for device 0000:00:1d.0 disabled
> Class driver suspend failed for cpu0
> Could not power down device firmware: error -22
> Some devices failed to power down
> 
> I've attached my entire dmesg as well.
Try with 2.6.19-rcX.
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
