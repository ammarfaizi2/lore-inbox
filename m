Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVKCP02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVKCP02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKCP01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:26:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54460 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030280AbVKCP00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:26:26 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 15:56:38 +0000
Message-Id: <1131033398.18848.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 16:02 +0100, Bartlomiej Zolnierkiewicz wrote:
> IMO porting/rewriting host-drivers to libata now is just
> counter-productive waste of time...

Face it, drivers/ide/ is beyong saving, it has entered the software
engineering twilight zone that follows 'maintainable'.

Shifting a non-complex driver to libata with a few libata improvements
is not a difficult process. Figuring out the extra hooks and bits to
make it clean is the difficult bit. Each time another PATA horror is
supported by libata it becomes easy for other cards with that horror to
be moved over.

Also drivers/ide contains detailed support for things that just aren't
worth moving over - like SWDMA.

Once the core support is done then quite frankly I'll be able to port a
PATA driver to libata faster than sherlock holmes could deduce the
drivers/ide locking "rules" let alone fix them.

Alan

