Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135352AbRDLVkJ>; Thu, 12 Apr 2001 17:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135350AbRDLVj4>; Thu, 12 Apr 2001 17:39:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:13310 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135349AbRDLVjh>; Thu, 12 Apr 2001 17:39:37 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <65256A2C.0032850D.00@sandesh.hss.hns.com> 
In-Reply-To: <65256A2C.0032850D.00@sandesh.hss.hns.com> 
To: npunmia@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RTC !! 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Apr 2001 22:39:29 +0100
Message-ID: <19975.987111569@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


npunmia@hss.hns.com said:
> The RTC interrupt  is programmable from 2 Hz to 8192 Hz, in powers of
> 2. So the interrupts that you could get are one of the following:
> 0.122ms, .244ms, .488ms, .977ms, 1.953ms, 3.906ms, 7.813ms, and so on.
>    Is there any  workaround , so that i can use RTC for meeting my
> requirement of an interrupt every 1.666..ms!!  ( I know that i can use
> UTIME or #define HZ 600, but i want to know if i can use RTC for this
> purpose ) 

You could also use the RTC  for providing the system tick (You'd need to 
make HZ a power of two, obviously) and then use the 8254 for providing your 
600Hz interrupt.

--
dwmw2


