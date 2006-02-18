Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWBRXUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWBRXUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWBRXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:20:33 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:46977 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932274AbWBRXUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:20:32 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       lk@bencastricum.nl, helgehaf@aitel.hist.no, fluido@fluido.as,
       gbruchhaeuser@gmx.de, Nicolas.Mailhot@LaPoste.net, perex@suse.cz,
       tiwai@suse.de, patrizio.bassi@gmail.com, bni.swe@gmail.com,
       arvidjaar@mail.ru, p_christ@hol.gr, ghrt@dial.kappa.ro,
       jinhong.hu@gmail.com, andrew.vasquez@qlogic.com,
       linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3 
In-Reply-To: Your message of "Wed, 15 Feb 2006 13:58:51 +0800."
             <3ACA40606221794F80A5670F0AF15F840AF2824B@pdsmsx403> 
Date: Sat, 18 Feb 2006 23:20:15 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FAbN9-0003T2-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I don't think anybody claimed this isn't a regression for the 600X.

>> I narrowed it further.  The short story is that this commit (diff
>> below sig) makes the second S3 sleep go into the endless loop, if
>> the loaded modules are exactly thermal, processor, intel_agp, and
>> agpgart:

> If you believe this patch is the root cause of the regression you
> have been seeing.

Not sure if you were waiting for me to say something, but I do believe
the change of default from ec_intr=0 to ec_intr=1 causes the problem
for me.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
