Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbVLGWgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbVLGWgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVLGWgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:36:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57759 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751806AbVLGWgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:36:53 -0500
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
	 <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
	 <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
	 <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Dec 2005 22:35:16 +0000
Message-Id: <1133994916.544.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-07 at 20:15 +0100, Bartlomiej Zolnierkiewicz wrote:
> PS1 Please don't use taskfile_lib_get_identify(), drive->id
> should contain valid ID - if it doesn't it is a BUG.

If someone swapped the drive while suspended that isnt true. OTOH I'm
not sure what the hell you'd do if that was the case and you are using
drivers/ide right now.

> PS2 Have you seen libata ACPI patches by Randy?
> Maybe some of the code dealing with ACPI can be put to
> <linux/ata.h> and be shared between IDE and libata drivers?

Definitely a good idea. Also exposing the methods will be useful for
producing a proper libata 'ata_acpi' driver that does the best it can
using ACPI methods for tuning unknown hardware.

