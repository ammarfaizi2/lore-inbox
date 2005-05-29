Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVE2Q7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVE2Q7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVE2Q7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:59:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30439 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261290AbVE2Q7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:59:18 -0400
Message-ID: <4299F4E2.4020305@pobox.com>
Date: Sun, 29 May 2005 12:59:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299EF16.2050208@pobox.com> <1117385429.4851.8.camel@localhost.localdomain>
In-Reply-To: <1117385429.4851.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> On Sun, 2005-05-29 at 12:34 -0400, Jeff Garzik wrote:
> 
>>>>Now, this patch is not complete. It should work and work well, but error
>>>>handling isn't really tested or finished yet (by any stretch of the
>>>>imagination). So don't use this on a production machine, it _should_ be
>>>>safe to use on your test boxes and for-fun workstations though (I run it
>>>>here...). I have tested on ich6 and ich7 generation ahci, and with
>>>>Maxtor and Seagate drives.
>>>
>>>Is this supposed to work on ICH7 in legacy mode as well?
>>
>>Nope.  ata_piix does not support NCQ (because the h/w doesn't support).
> 
> 
> If I understand this correctly: NCQ does not work on ICH7 in native mode
> (using ata_piix) because in this mode there is no NCQ available, right?

To be more specific, there are these modes:

	legacy mode		no NCQ
	combined mode		no NCQ
	native mode		no NCQ
	AHCI mode		NCQ


>>>Another question: is there a fundamental problem to have the ICH6/7
>>>enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
>>>don't offer the choice to enable AHCI (like mine :-().
>>
>>Not a problem.  You just don't get to use AHCI and such.
> 
> 
> Huh?
> 
> My question was if there is a fundamental reason why the AHCI mode of
> the ICH6/7 must be enabled by the BIOS, is there a reason why the kernel
> doesn't do it, or can't do it?

The BIOS sets up PCI resources necessary to use AHCI mode.

	Jeff


