Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVE2Qeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVE2Qeq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVE2Qeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:34:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25831 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261351AbVE2Qeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:34:37 -0400
Message-ID: <4299EF16.2050208@pobox.com>
Date: Sun, 29 May 2005 12:34:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <1117382598.4851.3.camel@localhost.localdomain>
In-Reply-To: <1117382598.4851.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> On Thu, 2005-05-26 at 16:00 +0200, Jens Axboe wrote:
> 
>>Now, this patch is not complete. It should work and work well, but error
>>handling isn't really tested or finished yet (by any stretch of the
>>imagination). So don't use this on a production machine, it _should_ be
>>safe to use on your test boxes and for-fun workstations though (I run it
>>here...). I have tested on ich6 and ich7 generation ahci, and with
>>Maxtor and Seagate drives.
> 
> 
> Is this supposed to work on ICH7 in legacy mode as well?

Nope.  ata_piix does not support NCQ (because the h/w doesn't support).


> Another question: is there a fundamental problem to have the ICH6/7
> enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
> don't offer the choice to enable AHCI (like mine :-().

Not a problem.  You just don't get to use AHCI and such.

	Jeff


