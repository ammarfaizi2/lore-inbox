Return-Path: <linux-kernel-owner+w=401wt.eu-S1751786AbXAOC1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbXAOC1J (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXAOC1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:27:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33785 "EHLO
	pd5mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbXAOC1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:27:08 -0500
Date: Sun, 14 Jan 2007 20:25:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <45AAC95B.1020708@garzik.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Message-id: <45AAE635.8090308@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>> Looks like all of these errors are from a FLUSH CACHE command and the 
>> drive is indicating that it is no longer busy, so presumably done. 
>> That's not a DMA-mapped command, so it wouldn't go through the ADMA 
>> machinery and I wouldn't have expected this to be handled any 
>> differently from before. Curious..
> 
> It's possible the flush-cache command takes longer than 30 seconds, if 
> the cache is large, contents are discontiguous, etc.  It's a 
> pathological case, but possible.
> 
> Or maybe flush-cache doesn't get a 30 second timeout, and it should...? 
>  (thinking out loud)
> 
>     Jeff

If the flush was still in progress I would expect Busy to still be set, 
however..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

