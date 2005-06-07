Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVFGNPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVFGNPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVFGNPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:15:18 -0400
Received: from wasp.net.au ([203.190.192.17]:9679 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261855AbVFGNOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:14:55 -0400
Message-ID: <42A59DD9.5090903@wasp.net.au>
Date: Tue, 07 Jun 2005 17:15:05 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050115)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com> <42A58307.3080906@wasp.net.au> <42A6AD46.5090200@rtr.ca>
In-Reply-To: <42A6AD46.5090200@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Brad Campbell wrote:
> 
> 
> That's weird.  So, is your /dev/sda a (S)ATA drive?

Yep.. I have 28 Maxtor Maxline-II drives on Promise SATA150TX4's
They all show up under /dev/scsi/host??

> 
> Maybe there's something screwy with true SATA drives and libata (doubtful)?

Not that I know of.. it has been working great here for months now.. (bar the odd oops)

> I also have "smartctl -data" working with SATA drives through the
> qstor driver (the non-libata version) without any issues, so we know
> the drives themselves are happy with it.
> 
>> smartctl -d ata -a /dev/sda

> Same thing as "-data".  Either works.
> 

So it does..

I'm still using a 2.6.10-bk10 kernel here with the libata-dev patches and some minor md patches.. 
It's stable unless one of the drives throws an error, whereapon libata oops and stops talking to the 
other drives (and then it gets really messy).. Have not had time to reproduce/upgrade to see if it's 
fixed though.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
