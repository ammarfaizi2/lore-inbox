Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUEYSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUEYSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUEYSPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:15:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20112 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S265023AbUEYSMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:12:47 -0400
Message-ID: <40B38CEB.6000807@tmr.com>
Date: Tue, 25 May 2004 14:14:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Modifying kernel so that non-root users have some root capabilities
References: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com> <Pine.LNX.4.53.0405250724490.2512@chaos>
In-Reply-To: <Pine.LNX.4.53.0405250724490.2512@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Mon, 24 May 2004, Laughlin, Joseph V wrote:
> 
> 
>>(not sure if this is a duplicate or not.. Apologies in advance.)
>>
>>I've been tasked with modifying a 2.4 kernel so that a non-root user can
>>do the following:
>>
>>Dynamically change the priorities of processes (up and down)
>>Lock processes in memory
>>Can change process cpu affinity
>>
>>Anyone got any ideas about how I could start doing this?  (I'm new to
>>kernel development, btw.)
>>
>>Thanks,
> 
> 
> You don't modify an operating system to do that!! You just make
> a priviliged program (setuid) that does the things you want.

Dick, it's called capabilities, and people have already modified the 
operating system to do that, it just doesn't work quite as intended in 
some cases. Setuid is the keys to the kingdom, you really don't want to 
use setuid root unless there's no other way.

Remember when everything used to take the BKL? Then people saw a better 
way. Capabilities is the same kind of progression, save the big hammer 
for the big nail.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
