Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVIVJkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVIVJkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVIVJkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:40:46 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42967 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030267AbVIVJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:40:44 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       bzolnier@gmail.com, Dominik Brodowski <linux@dominikbrodowski.net>,
       Mark Lord <liml@rtr.ca>, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1127339564.27462.7.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <20050921192932.GB13246@flint.arm.linux.org.uk>
	 <1127339564.27462.7.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 01:06:51 +0100
Message-Id: <1127347611.18840.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-21 at 22:52 +0100, Richard Purdie wrote:
> A proposed solution/patch:
> [One step further is to totally remove the drive->removable = 1]
> 
> This patch stops CompactFlash devices being marked as removable. They
> are not removable as the media and device are inseparable. When a card
> is removed, the device is removed from the system.


No it is not. The PCMCIA adapter does not generate a hot plug event when
the card is changed. This proposal is still wrong. Please either fix
your user space so it works (like the GNOME one does out of the box) or
propose a sensible kernel change to suppress the hotplug events such as
serial number checking. The latter sounds sensible to me because it
would cleanup somewhat.

Simply posting new variants of the wrong patch repeating false claims is
not a way to fix bugs.

Alan

