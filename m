Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWGAWXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWGAWXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGAWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:23:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49853 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750990AbWGAWXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:23:45 -0400
Message-ID: <44A6F5E3.8000300@zytor.com>
Date: Sat, 01 Jul 2006 15:23:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Ralf Baechle <ralf@linux-mips.org>, akpm@osdl.org,
       erik_frederiksen@pmc-sierra.com, linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>	<20060628140825.692f31be.rdunlap@xenotime.net>	<20060629181013.GA18777@linux-mips.org> <20060701114409.ed320be0.rdunlap@xenotime.net>
In-Reply-To: <20060701114409.ed320be0.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> 
> Are changes also needed in asm-*/unistd.h::syscall_return() macros?
> or is syscall_return() just not used?
> 
> e.g.,
> arm26 uses -125 to detect error
> arm uses -129 to detect error
> frv uses -4095 to detect error
> i386 uses -129
> h8300, m32r, s390, sh64, v850 use -125
> m68k[nommu] uses -125
> sh uses -124
> x86_64 uses -127
> 

... and they're pretty much all wrong (in some cases, they're actually 
less than actual errno values on that architecture!)

It pretty much works because they're not used.  They should either be 
fixed or removed.

	-hpa

