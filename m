Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTEJAVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 20:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTEJAVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 20:21:40 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:12702 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S263614AbTEJAVf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 20:21:35 -0400
Date: Fri, 09 May 2003 17:48:16 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support
 for SCO over HCI USB.
To: Greg KH <greg@kroah.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Message-id: <3EBC4C50.8040304@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
 <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
 <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com>
 <3EBBFC33.7050702@pacbell.net>
 <1052517124.10458.199.camel@localhost.localdomain>
 <20030509230542.GA3267@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, May 09, 2003 at 03:35:36PM -0700, Max Krasnyansky wrote:
> 
>>Ok. Sounds like it should be
>>	uint32_t hcd_cb[16]; // 64 bytes for internal use by HCD
>>	uint32_t drv_cb[2];  // 8  bytes for internal use by USB driver
> 
> 
> s/uint32_t/u32/ please.

"u32" is prettier, but is there actually a policy against using
the more standard type names?  (POSIX, someone had said.)


> And if this is going to be used for pointers, why not just say they are
> pointers?  Otherwise people are going to have to be careful with 32 vs.
> 64 bit kernels to not overrun their space.
> 
> struct sk_buff uses a char, any reason not to use that here too?  Has
> being a char made things more difficult for that structure over time?

No, it's just that in some similar cases having the value be "long"
(not "32 bit unsigned") has been simpler.  I'm not religious.

- Dave



