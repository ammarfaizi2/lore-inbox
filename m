Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbTIJScC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265457AbTIJScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:32:01 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53644 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265454AbTIJSb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:31:57 -0400
Message-ID: <3F5F6E12.8080802@nortelnetworks.com>
Date: Wed, 10 Sep 2003 14:31:46 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Martin Konold <martin.konold@erfrakon.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Luca Veraldi <luca.veraldi@katamail.com>, linux-kernel@vger.kernel.org
Subject: Re: Efficient IPC mechanism on Linux
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <200309101939.17967.martin.konold@erfrakon.de> <20030910180128.GP21086@dualathlon.random> <200309102005.36383.martin.konold@erfrakon.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Konold wrote:
> Am Wednesday 10 September 2003 08:01 pm schrieb Andrea Arcangeli:

>>with the shm/futex approch you can also have a ring buffer to handle
>>parallelism better while it's at the same time zerocopy
>>
> 
> How fast will you get? I think you will get the bandwidth of a memcpy for 
> large chunks?!
> 
> This is imho not really zerocopy. The data has to travel over the memory bus 
> involving the CPU so I would call this single copy ;-)

Even with zerocopy, you have to build the message somehow.  If process A 
builds a message and passes it to process B, then then isn't that as 
efficient as you can get with message passing?  How does MPI do any better?

However, if both processes directly map the same memory and use it 
directly (without "messages" as such), then I would see *that* as zerocopy.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

