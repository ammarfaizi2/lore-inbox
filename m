Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVGMP5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVGMP5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVGMP5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:57:19 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33035 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262978AbVGMP5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:57:03 -0400
Message-ID: <42D53A71.8030901@tmr.com>
Date: Wed, 13 Jul 2005 11:59:45 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org> <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org> <1120936561.6488.84.camel@mindpipe> <1121088186.7407.61.camel@localhost.localdomain> <20050711140510.GB14529@thunk.org>
In-Reply-To: <20050711140510.GB14529@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Mon, Jul 11, 2005 at 02:23:08PM +0100, Alan Cox wrote:
> 
>>>>Because some machines exhibit appreciable latency in entering low power
>>>>state via ACPI, and 1000Hz reduces their battery life.  By about half,
>>>>iirc.
>>>>
>>>
>>>Then the owners of such machines can use HZ=250 and leave the default
>>>alone.  Why should everyone have to bear the cost?
>>
>>They need 100 really it seems, 250-500 have no real effect and on the
>>Dell I tried 250 didn't stop the wild clock slew from the APM bios
>>either. I played with this a fair bit on a couple of laptops. I've not
>>seen anything > 20% saving however so I've no idea who/why someone saw
>>50%
> 
> 
> The real answer here is for the tickless patches to cleaned up to the
> point where they can be merged, and then we won't waste battery power
> entering the timer interrupt in the first place.  :-)

And that does seem to be the long term solution. Most (not all) modern 
hardware has a readable timer as accurate as the tick, so doing a timer 
to clock conversion as needed would be possible.

Unfortunately the interest in tickless operation seems to be mostly in 
the power saving possibilities of laptops. If you could make it part of 
some really sexy high interest area, like real time premption, it might 
get done sooner ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
