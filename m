Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283338AbRK2VDo>; Thu, 29 Nov 2001 16:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283384AbRK2VDf>; Thu, 29 Nov 2001 16:03:35 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:4574 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S283338AbRK2VD1>;
	Thu, 29 Nov 2001 16:03:27 -0500
Message-ID: <3C06A294.4070906@candelatech.com>
Date: Thu, 29 Nov 2001 14:03:16 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: ethernet links should remember routes the same as addresses
In-Reply-To: <3C068ED1.D5E2F536@nortelnetworks.com.suse.lists.linux.kernel> <p73r8qhqrmi.fsf@amdsim2.suse.de> <3C06A1C8.C133F725@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christopher Friesen wrote:


> If the driver re-init is totally separate from the routing code, is there any
> real reason why shutting down the driver *should* remove all routes to that
> device?  Maybe the simplest solution would be a new ioctl that would be a link
> *reset*...just down/up the link without affecting anything else....


What would want want the down/up to do?  The reason I ask is that there is
an MII-DIAG option to reset the transceiver, if that's all you want to do.

If you want to remove/re-install the driver, then you have to clean up
all the links pointing to it (ie the routes associated with the
device), or you will have all kinds of nasty dangling pointers (logical
or otherwise) to clean up...

Ben

> 
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


