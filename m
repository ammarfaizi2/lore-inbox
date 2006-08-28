Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWH1Pvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWH1Pvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWH1Pvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:51:42 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:47570
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1751110AbWH1Pvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:51:41 -0400
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Serial custom speed deprecated?
From: Michael Poole <mdpoole@troilus.org>
Date: Mon, 28 Aug 2006 11:51:40 -0400
In-Reply-To: <Pine.LNX.4.61.0608281047360.388@chaos.analogic.com> (linux-os@analogic.com's message of "Mon, 28 Aug 2006 10:50:45 -0400")
Message-ID: <87lkp8kgdv.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
References: <20060826181639.6545.qmail@science.horizon.com>
	<Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com>
	<1156775994.6271.28.camel@localhost.localdomain>
	<Pine.LNX.4.61.0608281047360.388@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os \(Dick Johnson\) writes:

> On Mon, 28 Aug 2006, Alan Cox wrote:
>
>> Ar Llu, 2006-08-28 am 08:17 -0400, ysgrifennodd linux-os (Dick Johnson):
>>> On Sat, 26 Aug 2006 linux@horizon.com wrote:
>>>
>>>>> Or we could just add a standardised extra set of speed ioctls, but then
>>>>> we need to decide what occurs if I set the speed and then issue a
>>>>> termios call - does it override or not.
>>>>
>>>> Actually, we're not QUITE out of bits.  CBAUDEX | B0 is not taken.
>>>
>>> B0 is not a bit (there are no bits in 0). It won't work.
>>
>> Well that is how it is implemented and everyone else seems happy. If it
>> violates your personal laws of physics you'll just have to cope.
>
> It has nothing to do with 'personal laws of physics'. On all recent
> implementations, B0 is 0, i.e., the absence of any bits set. Therefore,
> there is no observable difference between CBAUDEX and CBAUDEX | B0,
> as shown above. Therefore, as I stated, it won't work.

What baud rate does your system define CBAUDEX | B0 to be?  On my
AMD64 machine, both the x86-64 and i386 asm/termbits.h files skip
CBAUDEX -- B38400 is 0000017 and B57600 is 0010001 (CBAUDEX | B50).
The headers do not define any baud rate between those two, either by
rate or by c_cflag value.

Michael Poole
