Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTELSDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTELSC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:02:28 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:10686 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S262422AbTELRpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:45:00 -0400
Message-Id: <5.1.0.14.2.20030512105155.0d1773c0@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 12 May 2003 10:53:48 -0700
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.
  Support for SCO over HCI USB.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3EBC4C50.8040304@pacbell.net>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
 <200304290317.h3T3HOdA027579@hera.kernel.org>
 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
 <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
 <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com>
 <3EBBFC33.7050702@pacbell.net>
 <1052517124.10458.199.camel@localhost.localdomain>
 <20030509230542.GA3267@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:48 PM 5/9/2003, David Brownell wrote:
>Greg KH wrote:
>>On Fri, May 09, 2003 at 03:35:36PM -0700, Max Krasnyansky wrote:
>>
>>>Ok. Sounds like it should be
>>>        uint32_t hcd_cb[16]; // 64 bytes for internal use by HCD
>>>        uint32_t drv_cb[2];  // 8  bytes for internal use by USB driver
>>
>>s/uint32_t/u32/ please.
>
>"u32" is prettier, but is there actually a policy against using
>the more standard type names?  (POSIX, someone had said.)
>
>
>>And if this is going to be used for pointers, why not just say they are
>>pointers?  Otherwise people are going to have to be careful with 32 vs.
>>64 bit kernels to not overrun their space.
>>struct sk_buff uses a char, any reason not to use that here too?  Has
>>being a char made things more difficult for that structure over time?
>
>No, it's just that in some similar cases having the value be "long"
>(not "32 bit unsigned") has been simpler.  I'm not religious.
I don't care either. 'char' is ok for me.

So, I guess in general you're ok with adding ->drv_cb and ->hcd_cb to 'struct urb' ?

Max

