Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbSJVCKJ>; Mon, 21 Oct 2002 22:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSJVCKJ>; Mon, 21 Oct 2002 22:10:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262042AbSJVCKH>;
	Mon, 21 Oct 2002 22:10:07 -0400
Message-ID: <3DB4B4F8.5060205@pobox.com>
Date: Mon, 21 Oct 2002 22:16:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: VDA@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: ewrk3 cli/sti removal by VDA
References: <20021019021340.GA8388@www.kroptech.com> <3DB49D81.6000607@pobox.com> <20021022020932.GA13818@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> On Mon, Oct 21, 2002 at 08:36:17PM -0400, Jeff Garzik wrote:
> 
>>Adam Kropelin wrote:
>>
>>>Below is a patch from Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> 
>>>which
>>>removes cli/sti in the ewrk3 driver. It tests out fine here with SMP & 
>>>preempt.
>>
>>Applied and then cleaned up...  ETHTOOL_PHYS_ID needs to use 
>>schedule_timeout(), and using typeof should be avoided.
> 
> 
> The patch below (against yours) should fix ETHTOOL_PHYS_ID again. Let me
> know if I got it wrong. Was my prior use of
> wait_event_interruptible_tiumeout actually broken or rather
> just a lot more complicated than it needed to be?

broken in 2.4 -and- more complicated than it needed to be in 2.5.x ;-)


> I didn't find any use of typeof. If you point me to it I'll fix that up,
> too.

I fixed it up... grep your original patch.  typeof() was used because 
lp->pktStats was an anonymous structure with no defined typename.  I 
moved the struct out and gave it a name.


> Thanks for bearing with me. I'm climbing the clue-ladder as fast as I
> can... ;)

hehe, thanks for doing the patches and the testing... :)


> --- linux-2.5.44/drivers/net/ewrk3.c	Mon Oct 21 22:01:01 2002
> +++ linux-2.5.44/drivers/net/ewrk3.c.new	Mon Oct 21 21:58:13 2002

quick review says it looks good, I'll make another pass over it with my 
brain switched on, and apply or comment as it warrants :)

	Jeff



