Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUKXKvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUKXKvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUKXKvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:51:31 -0500
Received: from lucidpixels.com ([66.45.37.187]:4494 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262606AbUKXKv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:51:28 -0500
Date: Wed, 24 Nov 2004 05:44:46 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Michael Hunold <hunold-ml@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Question w/4port Ethernet Card & MII Transceivers
In-Reply-To: <41A4610B.3020707@web.de>
Message-ID: <Pine.LNX.4.61.0411240542530.11268@p500>
References: <Pine.LNX.4.61.0411230759070.3740@p500> <41A4610B.3020707@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the MII module/driver before loading the tulip board fixes the 
problem; I was curious what is the difference of the following:

1) No MII in physical HW and no SW driver loaded (mii module/driver)
2) No MMI in physical HW and sw driver loaded (what I have now, no warnings)
3) An MII in physical HW and no SW driver (better performance?)

I have not tried it with kernel 2.4.x.

To fix it, just make sure mii gets loaded before the tulip driver, or 
compile both of them in and you will not get the warnings.



On Wed, 24 Nov 2004, Michael Hunold wrote:

> Hi,
>
> I'm experiencing the same problems, see:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/0565.html
>
> On 23.11.2004 14:02, Justin Piszcz wrote:
>> Question regarding the warnings, it appears to find a MII transceiver but 
>> then it warns saying it does not?
>
> I'm having the same problem with a 2port card. After a cold boot, the 
> transceivers are not found and I need to do a reset. Afterwards, everything 
> is fine.
>
>> Is it a problem?
>
> For me, yes. I'm using one port to connect to my adsl provider. After a cold 
> boot, this fails.
>
>> If it is not using a HW tranceiver, does this cause a loss in performance?
>
> I don't know.
>
> Can you try to reboot the machine and see if the problem goes away (ie. the 
> transceivers are found)?
>
> Do you have a 2.4 kernel where the card works after a cold boot?
>
> So far nobody has come up with a solution and I don't reboot the machine that 
> often. But it's "good" to know that I'm not alone with the problem. ;-(
>
> CU
> Michael.
>
