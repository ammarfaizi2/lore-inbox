Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVBUU0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVBUU0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVBUU0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:26:36 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:21484 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S262094AbVBUU0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:26:19 -0500
Message-ID: <421A4375.9040108@nodivisions.com>
Date: Mon, 21 Feb 2005 15:24:21 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
In-Reply-To: <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>>It seems like this problem is always going to exist, because some hardware 
>>and some drivers will always be buggy.  So shouldn't we have some sort of 
>>watchdog higher up in the kernel, that watches for hung processes like this 
>>and kills them?
> 
> And said watchdog would clean up the mess, how, exactly?  There's lots of sticky
> issues having to do with breaking locks and possibly still-pending I/O (I once had
> a tape drive complete an I/O 3 *days* after the request was sent - good thing no
> watchdog killed the process and deallocated the memory that I/O landed in ;)

I'm not a kernel programmer, so I don't have the answers to any of that.  I 
guess I was thinking that there'd be some way to distinguish between 
processes that are truly stuck -- that is, never coming back -- and 
processes like yours, that are taking a long time but still working.

Or maybe it SHOULD have killed your process, in some "proper" way that 
prevents any outstanding I/O requests from coming in days later and breaking 
things.  Again, I'm no kernel hacker, but if an I/O request takes *3 days*, 
isn't that an indication of a bug or of faulty hardware perhaps?

> It's been covered before, look in the lkml archives for details.

Thanks, I'll do that.  But could you give me a more specific pointer? 
Searching lkml for "uninterruptible" returns ~2000 results.

Thanks,
Anthony DiSante
http://nodivisions.com/
