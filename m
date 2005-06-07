Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVFGNvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVFGNvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFGNvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:51:46 -0400
Received: from stark.xeocode.com ([216.58.44.227]:9376 "EHLO stark.xeocode.com")
	by vger.kernel.org with ESMTP id S261863AbVFGNvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:51:40 -0400
To: Mark Lord <liml@rtr.ca>
Cc: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com>
	<42A6AE3E.7070401@rtr.ca>
In-Reply-To: <42A6AE3E.7070401@rtr.ca>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 07 Jun 2005 09:51:23 -0400
Message-ID: <87is0qi8bo.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Lord <liml@rtr.ca> writes:

> Greg Stark wrote:
> > Uh, this is 2.6.12-rc4 with the latest libata-dev patch from Garzik's web
> > site:
> >  bash-3.00$ smartctl -data -a /dev/sda
> >  smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
> >  Home page is http://smartmontools.sourceforge.net/
> >  Smartctl: Device Read Identity Failed (not an ATA/ATAPI device)
> 
> Oh, wait a sec -- Jeff just posted that he's nuked the "read identity" ioctl(),
> so I suppose that has now broken smartmontools compatibility.

I think this libata-dev patch was prior to that announcement.

It's 2.6.11-bk6-libata-dev1.patch which I appear to have downloaded May 15th.
(Sorry I guess "latest" wasn't very precise)

> So Linux either goes without S.M.A.R.T. for SATA (again),
> or Jeff puts it back, or smartmontools gets upgraded Real Soon Now.

:(

What I really want to get working is actually hddtemp which uses SMART just to
get the temperature:

bash-3.00$ hddtemp /dev/hda
/dev/hda: MAXTOR 6L080J4: 50 C
bash-3.00$ hddtemp /dev/sda
/dev/sda: Maxtor 7Y250M0  YAR5: drive is sleeping
bash-3.00$ hddtemp /dev/sdb
/dev/sdb: Maxtor 6Y120M0  YAR5: drive is sleeping

The two M0 drives are SATA drives and they certainly are not sleeping. Come to
think of it that's awfully hot for the PATA drive. I think I'll put it to
sleep for a while.


-- 
greg

