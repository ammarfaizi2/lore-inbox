Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUIAAco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUIAAco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUIAAaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:30:04 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:54465 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269066AbUHaTps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:45:48 -0400
Message-ID: <4134D5EF.9080903@drzeus.cx>
Date: Tue, 31 Aug 2004 21:47:59 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: MMC block major dev
References: <4134CDF0.7070600@drzeus.cx> <20040831201556.B11053@flint.arm.linux.org.uk>
In-Reply-To: <20040831201556.B11053@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Tue, Aug 31, 2004 at 09:13:52PM +0200, Pierre Ossman wrote:
>  
>
>>It seems that the MMC block layer hasn't been assigned a major number. 
>>The code registers the block dev with a uninitialized variable. It then 
>>proceeds to create a mmc dir under devfs. Since I'm not using devfs this 
>>then poses a problem.
>>    
>>
>
>First, "uninitialised variables" is a misdescription here.  Variables
>declared outside the scope of functions are _always_ initialised even
>though there is no apparant assignment.
>
>They're placed in the BSS, or "zero initialised" section.  They have
>a well defined value.  Zero.
>
>Registering with the block layer with a major number of zero means
>"find me a free major number and assign that to me."  This is nothing
>new.  If devfs can't cope with that, devfs is buggy.  Use udev instead.
>
>  
>
Ok. Please excuse my ignorance =)
My point was that I do not use a dynamic system for /dev so it would be 
nice to have a static major number. Since MMC now is a part of Linus' 
kernel maybe it's time for a permanent allocation?

Rgds
Pierre

