Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWDJTQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWDJTQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWDJTQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:16:18 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:60455 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932104AbWDJTQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:16:17 -0400
In-Reply-To: <200604101211.23871.david-b@pacbell.net>
References: <Pine.LNX.4.44.0604051231030.17147-100000@gate.crashing.org> <200604101211.23871.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EDA713D2-AF06-4926-99D4-8F54221B621E@kernel.crashing.org>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Mon, 10 Apr 2006 14:16:17 -0500
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 10, 2006, at 2:11 PM, David Brownell wrote:

>
>> +
>> +#ifdef CONFIG_PPC_83xx
>> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
>> +	if (retval < 0)
>> +		return retval;
>> +
>> +	retval = platform_driver_register(&ehci_fsl_dr_driver);
>> +	if (retval < 0)
>> +		return retval;
>> +#endif
>> +
>> +#ifdef CONFIG_SOC_AU1X00
>> +	pr_debug(DRIVER_INFO " (Au1xxx)\n");
>> +
>> +	retval = driver_register(&ehci_hcd_au1xxx_driver);
>> +	if (retval < 0)
>> +		return retval;
>> +#endif
>
> Can we just get away from all of that extra #ifdeffery?
>
> This is essentially the same patch you sent the first time.
> With the same bugs ... like, not cleaning up the first driver
> after errors registering the second one.

Let me find a brown paper bag. The patch was suppose to be based on  
what you sent me fixed up to build and run for arch/powerpc...   
Clearly that's not the case. Let me work on a new version.

- k
