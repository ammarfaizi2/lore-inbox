Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275092AbTHGDlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 23:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275095AbTHGDlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 23:41:31 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:18090 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S275092AbTHGDla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 23:41:30 -0400
Message-ID: <3F31CED7.2070207@genebrew.com>
Date: Thu, 07 Aug 2003 00:00:23 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Jeff Sipek <jeffpc@optonline.net>, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
References: <200308061830.05586.jeffpc@optonline.net> <3F319EE7.8010409@techsource.com>            <200308062126.37658.jeffpc@optonline.net> <200308070312.h773Ce6h004590@turing-police.cc.vt.edu>
In-Reply-To: <200308070312.h773Ce6h004590@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 06 Aug 2003 21:26:30 EDT, Jeff Sipek said:
> 
> 
>>>Can you really DO (x < y > z) and have it work as an anded pair of
>>>comparisons?  Maybe this is an addition to C that I am not aware of.
>>>
>>>I would expect (x < y > z) to be equivalent to ((x < y) > z).
>>
>>Ah, very true. I wonder what the author intended. Also, since the 'z' is 0 in
>>all the cases, the statement "(i < TIMEOUT) > 0" can be reduced to "i < 
>>TIMEOUT".
> 
> 
> Of course, if the author intended (x<y) && (x > 0), you can't reduce it if
> x is at all possibly negative....

Doesn't matter; x is a loop index incrementing from 0 in this case.

Actually (correct me if I am wrong, but doesn't:

for(int i = 0; i < TIMEOUT > 0; i++)

translate to:

for(int i = 1; i < TIMEOUT; i++)

rather than:

for(int i = 0; i < TIMEOUT; i++)?

I hav not looked at the actual context of the code, but at least 
mathematically that makes more sense to me. i should never be 0 in the 
body of the loop, methinks?

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

