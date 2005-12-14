Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVLNWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVLNWra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVLNWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:47:29 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:64433 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S965054AbVLNWr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:47:28 -0500
Message-ID: <43A09F08.5000507@candelatech.com>
Date: Wed, 14 Dec 2005 14:39:04 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Sridhar Samudrala <sri@us.ibm.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>	 <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>	 <43A08546.8040708@superbug.co.uk> <1134597344.8855.1.camel@w-sridhar2.beaverton.ibm.com> <43A09811.2080909@superbug.co.uk>
In-Reply-To: <43A09811.2080909@superbug.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> Have you actually thought about what would happen in a real world senario?
> There is no real world requirement for this sort of user land feature.
> In memory pressure mode, you don't care about user applications. In 
> fact, under memory pressure no user applications are getting scheduled.
> All you care about is swapping out memory to achieve a net gain in free 
> memory, so that the applications can then run ok again.

Low 'ATOMIC' memory is different from the memory that user space typically
uses, so just because you can't allocate an SKB does not mean you are swapping
out user-space apps.

I have an app that can have 2000+ sockets open.  I would definately like to make
the management and other important sockets have priority over others in my app...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

