Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVFWCWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVFWCWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFWCTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:19:19 -0400
Received: from saturn.billgatliff.com ([209.251.101.200]:16574 "EHLO
	saturn.billgatliff.com") by vger.kernel.org with ESMTP
	id S261930AbVFWCOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:14:06 -0400
Message-ID: <42BA1ADB.6090006@billgatliff.com>
Date: Wed, 22 Jun 2005 21:13:47 -0500
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
References: <20050621062926.GB15062@kroah.com>	<20050620235403.45bf9613.akpm@osdl.org>	<20050621151019.GA19666@kroah.com>	<20050623010031.GB17453@mikebell.org> <20050622181825.204fbcb7.akpm@osdl.org>
In-Reply-To: <20050622181825.204fbcb7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:


>>It breaks a lot of my embedded setups which have read-only storage only
>>and thus need /dev on devfs or tmpfs.
>>    
>>
>
>Well that's quite a problem.  We're certainly causing people such as
>yourself to take on quite a lot of work.  But on the other hand we do want
>the kernel to progress sanely, and that sometimes involves taking things
>out.
>
>I don't have enough info to know whether the world would be a better place
>if we keep devfs, remove devfs or remove devfs even later on.  I don't
>think anyone knows, which is why we're taking this little
>disable-it-and-see-who-shouts approach.
>  
>

I would prefer to keep devfs around as well, but most of my embedded 
systems have enough RAM to put a primitive /dev tree in tmpfs using a 
linuxrc script at boot.  The workarounds for the userland requirements 
of udev are a little less clear to me, but I'm not sure they're 
insurmountable yet for anything except the smallest embedded systems, 
since Busybox appears to have some udev support available now.

I think that devfs and udev appeal to different audiences, hence I don't 
think you can say that the "world will be a better place" with one or 
the other.  It would be nice to find a way to have the two coexist 
peacefully...

Case in point.  I'm going to udev reluctantly; all my embedded work 
based on earlier kernels used devfs exclusively.


b.g.

-- 
Bill Gatliff
So what part of:
   $ make oldconfig clean dep zImage
do you not understand?
bgat@billgatliff.com

