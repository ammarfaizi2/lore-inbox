Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424134AbWKIREQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424134AbWKIREQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424135AbWKIREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:04:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:55720 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1424134AbWKIREO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:04:14 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,406,1157353200"; 
   d="scan'208"; a="158905302:sNHT3864016499"
Message-ID: <45535F66.8010803@intel.com>
Date: Thu, 09 Nov 2006 09:03:34 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: John <me@privacy.net>
CC: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, hpa@zytor.com, saw@saw.sw.com.sg
Subject: Re: Intel 82559 NIC corrupted EEPROM
References: <454B7C3A.3000308@privacy.net> <454BF0F1.5050700@zytor.com> <45506C9A.5010009@privacy.net> <4551B7B8.8080601@privacy.net> <45520337.2070303@intel.com> <45531C42.3070503@privacy.net>
In-Reply-To: <45531C42.3070503@privacy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 17:03:35.0792 (UTC) FILETIME=[FE756700:01C70420]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:
> Auke Kok wrote:
> 
>> This is what I was afraid of: even though the code allows you to 
>> bypass the EEPROM checksum, the probe fails on a further check to see 
>> if the MAC address is valid.
>>
>> Since something with this NIC specifically made the EEPROM return all 
>> 0xff's, the MAC address is automatically invalid, and thus probe fails.
> 
> I don't understand why you think there is something wrong with a
> specific NIC?

that was completely not my point - I was merely trying to point out that the original 
problem causes a cascade of error events later on, and bypassing the eeprom check in 
this case didn't help you at all. Something is wrong in the driver, but I don't 
understand yet why it only affects one of the 3 nics in your system.

> In 2.6.14.7, e100.ko fails to read the EEPROM on 0000:00:08.0 (eth0)
> In 2.6.18.1, e100.ko fails to read the EEPROM on 0000:00:09.0 (eth1)

almost sounds like a bug got fixed and it introduced a regression. this wouldn't be the 
right time to pull out git-bisect would it? even loading 2.6.15, 2.6.16, 2.6.17 on it 
would give us some good information.


Cheers,

Auke
