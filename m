Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUHIUQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUHIUQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUHIULW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:11:22 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:41898 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267184AbUHIUHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:07:54 -0400
Message-ID: <4117DA54.9090201@tmr.com>
Date: Mon, 09 Aug 2004 16:11:00 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Hamie <hamish@travellingkiwi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cs using 100% CPU
References: <4113DD20.1010808@travellingkiwi.com><40FA4328.4060304@travellingkiwi.com> <1091917597.19077.38.camel@localhost.localdomain>
In-Reply-To: <1091917597.19077.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-08-06 at 20:33, Hamie wrote:
> 
>>Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing 
>>the same job as quick, or even slightly faster...
> 
> 
> PCMCIA IDE is PIO only so it burns CPU. This is one case where
> hyperthreading is nice. Cardbus IDE is a lot better but very little
> exists and we don't currently support hotplug IDE controllers.
> 
> 
>>And should it not use system CPU rather than user CPU?
> 
> 
> Yes - but figure out please if the kernel or userspace is getting that
> wrong ;)

He didn't mention seeing waitio in his stats (or I missed it) so he may 
be using old userspace tools which don't show waitio.

Should this show as system or waitio? Typically waitio time can be used 
for other thaings and this can't, so perhaps showing it as system is 
correct in this case.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
