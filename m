Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266628AbUBRQez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266944AbUBRQey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:34:54 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:40662
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S266628AbUBRQev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:34:51 -0500
Message-ID: <40338FE8.60809@tmr.com>
Date: Wed, 18 Feb 2004 11:16:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
References: <20040217232130.61667965.akpm@osdl.org>
In-Reply-To: <20040217232130.61667965.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/
> 
> - Added the dm-crypt driver: a crypto layer for device-mapper.
> 
>   People need to test and use this please.  There is documentation at
>   http://www.saout.de/misc/dm-crypt/.
> 
>   We should get this tested and merged up.  We can then remove the nasty
>   bio remapping code from the loop driver.  This will remove the current
>   ordering guarantees which the loop driver provides for journalled
>   filesystems.  ie: ext3 on cryptoloop will no longer be crash-proof.
> 
>   After that we should remove cryptoloop altogether.
> 
>   It's a bit late but cyptoloop hasn't been there for long anyway and it
>   doesn't even work right with highmem systems (that part is fixed in -mm).

What definition of "stable kernel" do you use which includes removal of 
features which were reasons to migrate to 2.6 from 2.4? This change 
would mean having to add dm to the kernel which otherwise doesn't use 
it, carry dm utilities on the system whcih are otherwise unneeded, and 
train people to use and not use dm.

I expect major things to change in a development series, but less major 
things than this have been pushed to 2.7, why is this being forced in?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
