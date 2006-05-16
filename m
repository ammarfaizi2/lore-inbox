Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWEPXbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWEPXbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 19:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWEPXbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 19:31:03 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50841 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932283AbWEPXbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 19:31:01 -0400
Message-ID: <446A60A8.3090804@garzik.org>
Date: Tue, 16 May 2006 19:30:48 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Buesch <mb@bu3sch.de>, dsaxena@plexity.net,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       vsu@altlinux.ru
Subject: Re: [patch 6/9] Add VIA HW RNG driver
References: <20060515145243.905923000@bu3sch.de>	<20060515145317.142226000@bu3sch.de> <20060516152943.587b462d.akpm@osdl.org>
In-Reply-To: <20060516152943.587b462d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Michael Buesch <mb@bu3sch.de> wrote:
>> Signed-off-by: Michael Buesch <mb@bu3sch.de>
>> Index: hwrng/drivers/char/hw_random/Kconfig
>> ===================================================================
>> --- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
>> +++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:20.000000000 +0200
>> @@ -48,3 +48,16 @@
>>  	  module will be called geode-rng.
>>  
>>  	  If unsure, say Y.
>> +
>> +config HW_RANDOM_VIA
>> +	tristate "VIA HW Random Number Generator support"
>> +	depends on HW_RANDOM && X86
> 
> Perhaps you want X86_32 here.

correct (for now)


>> +	if (!cpu_has_xstore)
> 
> Because this doesn't exist on x86_64.

correct (for now)

	Jeff



