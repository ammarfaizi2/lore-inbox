Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUGELbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUGELbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUGELbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:31:36 -0400
Received: from guardian.hermes.si ([193.77.5.150]:3854 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S266025AbUGELbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:31:32 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C035F1D0C@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>, Dave Jones <davej@redhat.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: RE: Weird:  30 sec delay during early boot
Date: Mon, 5 Jul 2004 13:30:43 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, but GRUB also uses BIOS to access the hard drive(s).
And it can get a list of drives and read them just fine, without any delays.
Either there is a bug in the linux code or it somehow triggers some weird
BIOS bug.

Maybe a newer BIOS call should be used in linux EDD code ( I believe GRUB
uses
a different call for reading sectors than EDD )

Regards,
David

> ----------
> From: 	Dave Jones[SMTP:davej@redhat.com]
> Sent: 	5. julij 2004 13:25
> To: 	David Balazic
> Cc: 	Matt Domsch; Andries Brouwer; Jeff Garzik; Pavel Machek; Linux
> Kernel; Andi Kleen; Andrew Morton
> Subject: 	Re: Weird:  30 sec delay during early boot
> 
> On Mon, Jul 05, 2004 at 09:21:34AM +0200, David Balazic wrote:
>  > Wouldn't the BIOS immediatelly respond with a "no such disk" error if
> int13
>  > would
>  > try to access a non-existing disk ?
>  > This is BIOS land, not hardware land.
> 
> The BIOS guys get their stash from a different dealer to the hardware
> guys.
> Screwups happen. It could just be yet another 'interesting' interpretation
> of specifications.
> 
> 		Dave
> 
