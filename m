Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbULKVd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbULKVd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbULKVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:33:57 -0500
Received: from mout.alturo.net ([212.227.15.20]:21192 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S262017AbULKVdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:33:44 -0500
Message-ID: <41BB4951.2080304@datafloater.de>
Date: Sat, 11 Dec 2004 20:24:01 +0100
From: Arne Caspari <arne@datafloater.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/base/driver.c : driver_unregister
References: <41BB4268.8020908@datafloater.de> <20041211191113.A13985@flint.arm.linux.org.uk>
In-Reply-To: <20041211191113.A13985@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sat, Dec 11, 2004 at 07:54:32PM +0100, Arne Caspari wrote:
>  
>
>>I think the meaning of this patch is obvious: In driver_unregister, the 
>>bus_remove_driver function call was called outside the driver unload 
>>semaphore which should obviously protect it.
>>    
>>
>
>No.  The semaphore is there to ensure that the function does not
>return until the driver structure has a use count of zero.  If you
>tested your patch, you'd find that your change would deadlock on
>the locked semaphore.
>  
>

Russell,

Ah, now I understand that thing.  Reading the comments again, I should 
have seen the reason for this earlier.

I am sorry I can not test that patch since unloading of the modules I am 
currently testing blocks anyway. This makes it very hard to test the 
patch :-( and currently this was the reason why I was going to this.

Sorry if I caused any inconvenience.

 /Arne


