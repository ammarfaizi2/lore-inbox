Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWEEFnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWEEFnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWEEFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:43:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39093 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750935AbWEEFnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:43:23 -0400
Message-ID: <445AE690.5030700@sgi.com>
Date: Fri, 05 May 2006 07:45:52 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
References: <20060504180614.X88573@chenjesu.americas.sgi.com> <20060504173722.028c2b24.rdunlap@xenotime.net>
In-Reply-To: <20060504173722.028c2b24.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Thu, 4 May 2006 18:09:45 -0500 (CDT) Brent Casavant wrote:
> 
>> Move various QLogic, Vitesse, and Intel storage
>> controller PCI IDs to the main header file.
>>
>> Signed-off-by: Brent Casavant <bcasavan@sgi.com>
>>
>> ---
>>
>> As suggested by Andrew Morton and Jes Sorenson.
> 
> as compared to:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b860b8c4bde5949b272968597d1426d53080532

I guess Andrew and I should be blamed for that. I Andrew suggested
putting the IDs in the 'right place' and I took the right place as being
the pci_ids.h file.

Can't say I agree with the recommendation, having them in pci_ids.h is
nice and clean and it allows one to go look through the list, instead
they now really become random hex values :( Brent's patch is a perfect
example of IDs being used in multiple places, ie. the qla1280 driver
and in the IOC4 driver, so the claim in that Documentation/ file doesn't
hold water.

Anyway, if this is the new rule, then I guess it's back to using the
ugly patch :(

Jes
