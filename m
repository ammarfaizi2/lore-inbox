Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVLGOBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVLGOBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVLGOBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:01:37 -0500
Received: from proxy.seznam.cz ([212.80.76.5]:49677 "EHLO proxy.seznam.cz")
	by vger.kernel.org with ESMTP id S1751053AbVLGOBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:01:36 -0500
Message-ID: <4396EB32.4010800@feix.cz>
Date: Wed, 07 Dec 2005 15:01:22 +0100
From: Michal Feix <michal@feix.cz>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] SCSI block devices larger then 2TB
References: <4396B795.1000108@feix.cz> <20051207123519.GA17414@infradead.org>
In-Reply-To: <20051207123519.GA17414@infradead.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Greetings!
>>
>>Current aic79xxx driver doesn't see SCSI devices larger, then 2TB. It 
>>fails with READ CAPACITY(16) command. As far as I can understand, we 
>>already have LBD support in kernel for some time now. So it's only the 
>>drivers, that need to be fixed? LSI driver is the only one I found 
>>working with devices over 2TB; I couldn't test any other driver, as I 
>>don't have the hardware. Is it really so bad, that only LSI chipset and 
>>maybe few others are capable of seeng such devices?
> 
> 
> I definitly works fine with Qlogic parallel scsi and fibrechannel and emulex
> fibre channel controllers aswell as lsi/engenio megaraid controllers.
> 
> It looks like aci79xx is just broken in that repsect. Unfortunately the
> driver doesn't have a proper maintainer, we scsi developers put in fixes
> and cleanups but we don't have the full documentation to fix such complicated
> issue.  If you have a support contract with Adaptec complain to them.

As we do not have any special support contract with Adaptec, it's 
probably a dead end. I found some aic79xx driver on Adaptec website for 
2.6 kernel. It detects full SCSI device capacity, but it hangs 
ocassionaly when that drive is beeing accessed, so it's unusable for 
every day use.

Anyway, thanks for the info. And to everyone else, beware of Adaptec 
SCSI host adapters when using large SCSI arrays... :(
