Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSJQWzE>; Thu, 17 Oct 2002 18:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbSJQWzE>; Thu, 17 Oct 2002 18:55:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262314AbSJQWy6>;
	Thu, 17 Oct 2002 18:54:58 -0400
Message-ID: <3DAF412A.7060702@pobox.com>
Date: Thu, 17 Oct 2002 19:00:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: "David S. Miller" <davem@redhat.com>, greg@kroah.com, hch@infradead.org,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
References: <20021017195015.A4747@infradead.org>	<20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com> <3DAF3EF1.50500@domdv.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> David S. Miller wrote:
> 
>> The more I look at LSM the more and more I dislike it, it sticks it's
>> fingers everywhere.  Who is going to use this stuff?  %99.999 of users
>> will never load a security module, and the distribution makers are
>> going to enable this NOP overhead for _everyone_ just so a few telcos
>> or government installations can get their LSM bits?
>>
> 
> I'm going to ignore the overhead stated above here. And please take the 
> following as a comment/personal opinion you may as well ignore. But I'm 
> somewhat irritated, so:
> 
> <sarcasm>
> So users are dumb in general, why not apply the "Single user linux" 
> patch? If you don't remember: http://www.surriel.com/potm/apr2001.shtml
> </sarcasm>
> 
> Honestly, if you don't offer a patchless option to tighter security you 
> can't estimate usage.
> 
> Given that LSM becomes a standard part of the kernel it would be easy 
> for distros to offer "trusted" installations based on LSM. And in this 
> case advanced security will spread.

No offense, please, but I really think David is being very reasonable.

The normal "Linux way" is to have zero overhead unless something is 
actually used -- witness spinlocks on UP versus SMP.

Regardless of whether some people feel the "majority" will be using LSM 
at some point in the future, David's point is very valid today, and for 
some time to come.

Finally, I was under the impression that Greg KH agreed that it is 
possible to eliminate this overhead?  Maybe I recall incorrectly.

Respectfully,

	Jeff


