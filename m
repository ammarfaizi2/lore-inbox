Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUGEHWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUGEHWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 03:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUGEHWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 03:22:51 -0400
Received: from guardian.hermes.si ([193.77.5.150]:6671 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S265799AbUGEHWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 03:22:49 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C035F1CB0@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: Matt Domsch <Matt_Domsch@dell.com>, Andries Brouwer <aebr@win.tue.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, David Balazic <david.balazic@hermes.si>
Subject: RE: Weird:  30 sec delay during early boot
Date: Mon, 5 Jul 2004 09:21:34 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't the BIOS immediatelly respond with a "no such disk" error if int13
would
try to access a non-existing disk ?
This is BIOS land, not hardware land. The BIOS already has a list of
"existing" drives.
Or maybe I'm flat out wrong ;-)

Regards,
David

> ----------
> From: 	Andries Brouwer[SMTP:aebr@win.tue.nl]
> Sent: 	5. julij 2004 1:27
> To: 	Matt Domsch
> Cc: 	Jeff Garzik; Pavel Machek; Linux Kernel; Andi Kleen; Andrew Morton;
> David Balazic
> Subject: 	Re: Weird:  30 sec delay during early boot
> 
> On Sun, Jul 04, 2004 at 03:52:51PM -0500, Matt Domsch wrote:
> 
> > Only that it's now probing more than just the first disk, but the
> > first 16 possible BIOS disks.  If the BIOS behaves badly to an int13
> > READ_SECTORS command, that'd be good to know...
> 
> I recall text fragments like
> 
>  "Any device claiming compliance to ATA-3 or later as indicated in
>   IDENTIFY DEVICE or IDENTIFY PACKET DEVICE data should properly
>   release PDIAG- after a power-on or hardware reset upon receiving
>   the first command or after 31 seconds have elapsed since the reset,
>   whichever comes first."
> 
> that seem to imply that probing a nonexistent device may take 31 sec
> before one is allowed to conclude that there is nothing there.
> 
> Andries
> 
> 
> (ide_wait_hwif_ready() used to wait 35 seconds)
> 
