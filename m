Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbULMIYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbULMIYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 03:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbULMIYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 03:24:23 -0500
Received: from mout.alturo.net ([212.227.15.21]:13822 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261773AbULMIYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 03:24:19 -0500
Message-ID: <41BD42E6.6000402@datafloater.de>
Date: Mon, 13 Dec 2004 08:21:10 +0100
From: Arne Caspari <arne@datafloater.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] drivers/base/driver.c : driver_unregister
References: <41BB4268.8020908@datafloater.de> <20041211191113.A13985@flint.arm.linux.org.uk> <41BB4951.2080304@datafloater.de>
In-Reply-To: <41BB4951.2080304@datafloater.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Caspari wrote:
> Russell King wrote:
>> No.  The semaphore is there to ensure that the function does not
>> return until the driver structure has a use count of zero.  If you
>> tested your patch, you'd find that your change would deadlock on
>> the locked semaphore.
 >
> I am sorry I can not test that patch since unloading of the modules I am 
> currently testing blocks anyway. This makes it very hard to test the 
> patch :-( and currently this was the reason why I was going to this.

I reverted the code to the original 2.6.9 and unloading of IEEE1394 
modules like 'eth1394' does just that: It deadlocks on this semaphore.

At least this is a good excuse why I was not able to test my patch ;-) 
The behaviour just remained the same as before...

Btw. I am developing/debugging on a machine without serial/parallel 
ports. Is there a way to connect a kernel mode debugger to this. I am 
used to windows development and there the debugger works on a IEEE1394 
connection. Does anybody have hints to improve development on such a 
machine?


Thanks,

	/Arne

