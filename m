Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTLaNCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 08:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTLaNCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 08:02:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264605AbTLaNCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 08:02:33 -0500
Message-ID: <3FF2C8D5.2050205@pobox.com>
Date: Wed, 31 Dec 2003 08:02:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Woods <kazrak+kernel@cesmail.net>
CC: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: ICH5 docs
References: <20031230164953.GB4868@atrey.karlin.mff.cuni.cz> <3FF1B43A.9090707@pobox.com> <6.0.1.1.0.20031231003359.024626f0@no.incoming.mail>
In-Reply-To: <6.0.1.1.0.20031231003359.024626f0@no.incoming.mail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Woods wrote:
> At 12/30/2003 12:22 PM -0500, Jeff Garzik wrote to linux-kernel:
> 
>> Karel Kulhavy wrote:
>>
>>> Where can I learn about ICH5 SATA RAID driver in Linux kernel 2.6.0?  I
>>
>>
>> Intel "RAID" is software RAID.  There isn't any hardware RAID assist...
>> So ICH5 looks pretty much just like any other PATA host controller.
> 
> 
> Oh?  My understanding (which I admit is very high-level) is that Intel's 
> ICH5 southbridge supports SATA; but to get SATA+RAID requires the ICH5R 
> southbridge.  If not, what are the practical differences (if any) 
> between the ICH5 and ICH5R?


None; as I said, Intel's RAID is _software_ RAID.  You simply need to 
use the "iswraid" Linux driver to access the proprietary vendor RAID 
metadata format on your disks.

If you do not wish to be locked into proprietary vendor RAID, then just 
use Linux's md RAID, and you may pretend that ICH5 and ICH5R are exactly 
the same :)

	Jeff



