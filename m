Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVEITZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVEITZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEITYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:24:31 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:37532 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261479AbVEITWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:22:50 -0400
Message-ID: <427FA557.3030400@tmr.com>
Date: Mon, 09 May 2005 14:00:55 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> On Tue, 19 Apr 2005, Nico Schottelius wrote:
> 
>>When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
>>varies very much on different architectures.
> 
> 
> Yep, and it has been this way since the begining of time.
> 
> 
>>So that one at least can count the cpus on every system the same way.
> 
> 
> Hah.  Give me a minute to stop laughing...  I argued the same point almost
> a decade ago.  Linus decided to be an ass and flat refused to ever export
> numcpu (or any of the current day derivatives) which brought us to the
> bullshit of parsing the arch dependant /proc/cpuinfo.

Don't ever take up a career as a diplomat, no one in their right mind 
would want such a tactless person for a diplomatic job, say UN ambasador 
for instance.

Linus did what was probably right then. I would agree that there is room 
for something better now. Just to prove it could be done (not that this 
is the only or best way):

   cpu0 {
     socket: 0
     chip-cache: 0
     num-core: 2
     per-core-cache: 512k
     num-siblings: 2
     sibling-cache: 0
     family: i86
     features: sse2 sse3 xxs bvd
     # stepping and revision info
   }
   cpu1 {
     socket: 1
     chip-cache: 0
     num-core: 1
     pre-core-cache: 512k
     num-siblings: 2
     sibling-cache: 64k
     family: i86
     features: sse2 sse3 xxs bvd kook2
     # stepping and revision info
   }

This is just proof of concept, you can have per-chip, per-core, and 
per-sibling cache for instance, but I can't believe that anyone would 
make a chip where the cache per core or per sibling differed, or the 
instruction set, etc. Depending on where you buy your BS, Intel and AMD 
will (or won't) make single and dual core chips to fit the same socket.

The complexity wasn't needed a decade ago, and I'm not sure it is now, 
other than it being easy to display if people don't complain about 
breaking the existing format.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

