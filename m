Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131628AbQLNSds>; Thu, 14 Dec 2000 13:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131968AbQLNSdi>; Thu, 14 Dec 2000 13:33:38 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:49156 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131628AbQLNSd2>; Thu, 14 Dec 2000 13:33:28 -0500
Message-Id: <200012141802.eBEI2is52509@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 17:54:54 GMT."
             <E146cal-0000JD-00@the-village.bc.nu> 
Date: Thu, 14 Dec 2000 11:02:44 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I figured as much.  I will test for the #define, stash it in a #define
>> unique within my namespace, and #define it back in hosts.c should my
>> local define exist.
>
>If that driver hits a tree I maintain be aware that the first thing I will do
>is rip that out and rename the 'current' variables in it 8)

The only reason "namespace restoration" is an issue at all is due to the
poor design of hosts.c in 2.2.X kernels.  A better solution would be to
bring in the build hooks from 2.4 so modules and compiled in drivers are
handled the same way - a way that lets drivers do what they want with
their namespace without touching that of any other portion of the kernel.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
