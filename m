Return-Path: <linux-kernel-owner+w=401wt.eu-S932155AbXAPAhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbXAPAhm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbXAPAhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:37:41 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51057 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbXAPAhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:37:41 -0500
Date: Mon, 15 Jan 2007 18:36:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <20070116002336.GB4067@kernel.dk>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Message-id: <45AC1E18.8030403@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org>
 <45AAE635.8090308@shaw.ca> <20070115025319.GC4516@kernel.dk>
 <45AB84D8.3020507@garzik.org> <20070116002336.GB4067@kernel.dk>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Jan 15 2007, Jeff Garzik wrote:
>> Jens Axboe wrote:
>>> I'd be surprised if the device would not obey the 7 second timeout rule
>>> that seems to be set in stone and not allow more dirty in-drive cache
>>> than it could flush out in approximately that time.
>> AFAIK Windows flush-cache timeout is 30 seconds, not 7 as with other 
>> commands...
> 
> Ok, 7 seconds for FLUSH_CACHE would have been nice for us too though, as
> it would pretty much guarentee lower latencies for random writes and
> write back caching. The concern is the barrier code, of course. I guess
> I should do some timings on potential worst case patterns some day. Alan
> may have done that sometime in the past, iirc.
> 

Note that the ATA-7 spec for FLUSH CACHE says that "This command may 
take longer than 30 s to complete."

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

