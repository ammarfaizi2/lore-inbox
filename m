Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVFGMde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVFGMde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 08:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFGMde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 08:33:34 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:24580 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261388AbVFGMdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 08:33:32 -0400
Message-ID: <42A6AD46.5090200@rtr.ca>
Date: Wed, 08 Jun 2005 04:33:10 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
Cc: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com> <42A58307.3080906@wasp.net.au>
In-Reply-To: <42A58307.3080906@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> Greg Stark wrote:
>> Uh, this is 2.6.12-rc4 with the latest libata-dev patch from Garzik's web
>> site:
>>
>>  bash-3.00$ smartctl -data -a /dev/sda
>>  Smartctl: Device Read Identity Failed (not an ATA/ATAPI device)

That's weird.  So, is your /dev/sda a (S)ATA drive?
I haven't tried it on 2.6.12-rc*  (breaks VMware for me+ libata-dev),
but it does work fine for 2.6.11 + libata-dev on my PATA drive.

Maybe there's something screwy with true SATA drives and libata (doubtful)?

I also have "smartctl -data" working with SATA drives through the
qstor driver (the non-libata version) without any issues, so we know
the drives themselves are happy with it.

> smartctl -d ata -a /dev/sda

Same thing as "-data".  Either works.
