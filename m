Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbULaRy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbULaRy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbULaRyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:54:15 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:45965 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261713AbULaRvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:51:09 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Date: Fri, 31 Dec 2004 12:51:04 -0500
User-Agent: KMail/1.7
Cc: William <wh@designed4u.net>
References: <200412311741.02864.wh@designed4u.net>
In-Reply-To: <200412311741.02864.wh@designed4u.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311251.04187.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 11:51:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 12:41, William wrote:
>Hi
>
>I am a linux desktop user. I love linux and all the wonderfull
>open-source/free software that comes with it... blah, blah, blah :).
> The following comments and suggestions about umount() stem from
> personal experience and are meant as friendly feedback for all you
> clever people. (I wish I understook how the kernel works)
>
>Regularly, when attempting to umount() a filesystem I receive
> 'device is busy' errors. The only way (that I have found) to solve
> these problems is to go on a journey into processland and kill all
> the guilty ones that have tied themselves to the filesystem
> concerned.
>
If you are running kernel.org kernels, the fix is to update to at 
least 2.6.10-ac1, where much of this malarkey, particularly with 
regard to samba, has been attended to.

>In order to help solve this problem is it possible to modify the
> behaviour of the linux kernel.
>
>In my opinion, in order for linux to be trully user friendly, "a
> umount() should NEVER fail" (even if the device containing the
> filesystem is no longuer attached to the system). The kernel should
> do it's best to satisfy the umount request and cleanup. Maybe the
> kernel could try some of the following:
>
>1) if the device containing the filesystem (for local filesystems)
> is no longer physicaly attached to the system: revoke all process
> access to the filesystem and umount. Notify umount that the
> filesystem was not cleanly umounted.
>
>2) notify all processes attached to the filesystem that they must
> release control of it.
>
>3) the processes may respond to the notifications and request time
> to clean up in order to read/write any remaining data.
>
>4) processes that do not respond within a given time-frame should
> have their filesystem access revoked.
>
>5) once all the clean up has finnished...  umount the
> filesystem.....
>
>I am not subscribed to the list so please email me on
> wh@designed4u.net
>
>Kind Regards
>      William Heyland
>
>the new "a umount() should NEVER fail" campaign launched by me on
> december the 31 of 2004.  Just in time for new year ;-)
>
>PS:  I am currently teaching myself about kernels in general and am
> hoping to start contributing to linux soon. But until then... if
> the kernel can't handle a umount() then nothing in userspace can do
> any better... rant, rant, rant, ...  make umount() smarter....
> Please?
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
