Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUHCPkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUHCPkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 11:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUHCPkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 11:40:09 -0400
Received: from main.gmane.org ([80.91.224.249]:14028 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266670AbUHCPjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 11:39:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH] speedy boot from usb devices
Date: Wed, 04 Aug 2004 00:39:46 +0900
Message-ID: <ceobk3$5lh$1@sea.gmane.org>
References: <87fz79xk5q.fsf@dedasys.com> <410E27DC.4090009@grupopie.com> <876581s0j7.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <876581s0j7.fsf@dedasys.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:
> Paulo Marques <pmarques@grupopie.com> writes:
> 
> 
>>David N. Welton wrote:
> 
> 
>>>        Works like so: whenever a block device comes on line, it
>>>        signals this fact to a wait queue, so that the init
>>>        process can stop and wait for slow devices, in particular
>>>        things such as USB storage devices, which are much slower
>>>        than IDE devices.  The init process checks the list of
>>>        available devices and compares it with the desired root
>>>        device, and if there is a match, proceeds with the
>>>        initialization process, secure in the knowledge that the
>>>        device in question has been brought up.  This is useful if
>>>        one wants to boot quickly from a USB storage device
>>>        without a trimmed-down kernel, and without going through
>>>        the whole initrd slog.
>>I find this to be very useful. I always found the "sleep for a while
>>until the device we want appears" approach very cumbersome.

I hope it works. I tried to hack some delay on my own, but without success :-(
Will try this patch.

> Glad to hear someone likes it.
> 
> 
>>However, after looking at your patch, it seems that having a
>>get_blkdevs() function that alloc's an array of strings, and return
>>it to a function that only compares the strings against the name it
>>is looking for and drops the array altogether, is a little overkill.
>>Why not have a simple blkdev_exists(char *name) function in genhd.c,
>>call it directly, and drop the match_root_name() function
>>completely?
> 
> 
> Sure, that's probably better.  Maybe "blkdev_is_online"?  I'll see if
> I can do it tommorow.

Waiting :-)
I am planing to run a Gentoo-based small dist off a 128MB USB flash.

> I'm also a bit dubious of having the wait queue floating around as a
> global, but don't know the kernel well enough to find it a better
> home.

Thumbs up!

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

