Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbUBZCs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUBZCs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:48:29 -0500
Received: from adsl-b3-196-142.telepac.pt ([213.13.196.142]:17926 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S261529AbUBZCs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:48:26 -0500
Message-ID: <403D5E7F.1080700@vgertech.com>
Date: Thu, 26 Feb 2004 02:48:31 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
Cc: John Lee <johnl@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com>
In-Reply-To: <403D3E47.4080501@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timothy Miller wrote:

[..]

> 
> 
> It's a security concern to have to login as root unnecessarily.  It's 
> bad enough we have to do that to change X11 configuration, but we 
> shouldn't have to do that every time we want to start xmms.  And just 
> suid root is also a security concern.
> 

Maybe I'm missing something, but xmms run OK with zero load, right? The 
problem is that, when building the kernel and the entire kde tree, each 
with make -j 16, xmms skips a few times? Well, tough luck...

And the user *can* do something about it, just nice -n 19 the builds and 
left xmms alone. (Or you can use other player... :-)

With this patch you can even say that each of the build processes can 
only hog 5% (at the most!) of the CPU (maybe the build is not a good 
example for mandatory CPU time caps, but it is usefull).

Besides, this implements a true run-only-when-noone-else-wants-to-run 
nice mode wich, combined with the absolut cpu time caps, hits some of my 
wish list for a complete scheduler :-) so I can't wait to test it :-)

A final note to John Lee: you may want to check the Class-based Kernel 
Resource Management (CKRM) at:
	http://ckrm.sourceforge.net/

Thanks,
Nuno Silva



