Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbQLNOaR>; Thu, 14 Dec 2000 09:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQLNO36>; Thu, 14 Dec 2000 09:29:58 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:27411 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130287AbQLNO3q>; Thu, 14 Dec 2000 09:29:46 -0500
Message-Id: <200012141359.eBEDxFs46530@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 10:14:51 GMT."
             <E146VPa-00044k-00@the-village.bc.nu> 
Date: Thu, 14 Dec 2000 06:59:15 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll update my patch tomorrow to restore the definition of current.
>> I do fear, however, that this will perpetuate the polution of the
>> namespace should "current" ever get cleaned up.
>
>It can probably get cleaned up after 2.4 by making current() the actual 
>inline. For 2.2 it won't change. Consider it a feature.
>
>It was done originally because the 2.0 code using #define based current
>generated better code than using inline functions. 2.2 upwards use a different
>(far nicer) method to find current.
>
>Note also that you cannot rely on 'get_current()'. The only way to find 
>current is to use current. get_current() the inline is an x86ism.

I figured as much.  I will test for the #define, stash it in a #define
unique within my namespace, and #define it back in hosts.c should my
local define exist.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
