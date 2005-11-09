Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVKIQkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVKIQkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVKIQkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:40:07 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:27670 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750955AbVKIQkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:40:05 -0500
Message-ID: <437226B2.10901@tmr.com>
Date: Wed, 09 Nov 2005 11:41:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
References: <20051103220305.77620d8f.akpm@osdl.org>	 <20051104071932.GA6362@kroah.com>	 <1131117293.26925.46.camel@localhost.localdomain>	 <20051104163755.GB13420@kroah.com> <1131531428.8506.24.camel@localhost.localdomain>
In-Reply-To: <1131531428.8506.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> On Fri, 2005-11-04 at 08:37 -0800, Greg KH wrote:
> 
>>On Fri, Nov 04, 2005 at 03:14:53PM +0000, Alan Cox wrote:
>>
>>>On Iau, 2005-11-03 at 23:19 -0800, Greg KH wrote:
>>>
>>>>Hint, gentoo, debian, and suse don't have this problem, so you might
>>>>want to look at their rules files for how to work around this.  Look for
>>>>this line:
>>>>
>>>># skip accessing removable ide devices, cause the ide drivers are horrible broken
>>>
>>>
>>>I was under the impression people had eventually decided the media
>>>change patch someone was proposed was ok after investigating one or two
>>>cases I knew of that turned out to be borked hardware ?
>>
>>I was not aware of that, I'd be glad to see that patch go into the tree
>>to help others who have run into this over the years.
>>
>>Hm, have a pointer to the latest proposed patch for this anywhere?
> 
> 
> This was discussed in the thread: http://lkml.org/lkml/2005/9/21/118
> 
> Alan Cox:
> 
>>On Iau, 2005-09-22 at 15:21 +0100, Richard Purdie wrote:
>>
>>>1. Are ide-cs devices removable or not. See above.
>>
>>Having done testing on the cards I have based on RMK's suggestion I
>>agree they are not removable except for specific cases (IDE PCMCIA cable
>>adapter plugged into a Syquest). That case is already handled in the
>>core code.
> 
> 
> Alan: Can you confirm the patch below continues to handle the case
> you're talking about?
> 
> 
>>The fact cache flushing is all odd now is I guess bug 4. on the list but
>>easy to fix while fixing 1
> 
> 
> I don't know the ide code well enough to understand what needs fixing
> here. Can you elaborate further?
> 
> I'll resend this patch as it still applies and we seem to be in general
> agreement about what needs doing. There was also the issue of media
> change serial number checking but that really needs tackling separately.
> 
> 
> This patch stops CompactFlash devices being marked as removable. They
> are not removable (as defined by Linux) as the media and device are 
> inseparable. When a card is removed, the whole device is removed from 
> the system and never sits in a media-less state.

Having used CF devices for some years (since RH 8.0) I'm not sure what 
problem you're addressing here. Could you describe what problem you're 
having, and also note what current functionality this will change?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
