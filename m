Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSK3U7g>; Sat, 30 Nov 2002 15:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSK3U7g>; Sat, 30 Nov 2002 15:59:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30225 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261587AbSK3U7f>;
	Sat, 30 Nov 2002 15:59:35 -0500
Message-ID: <3DE92854.6000000@pobox.com>
Date: Sat, 30 Nov 2002 16:06:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C99 initializers for drivers/media/radio
References: <E18IEk7-0003yA-00@calista.inka.de>
In-Reply-To: <E18IEk7-0003yA-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <20021130174509.GD10613@debian> you wrote:
> 
>>Here's a patch set for switching drivers/media/radio to use C99
>>initializers. The patches are against 2.5.50.
> 
> ...
> 
>>static struct pcm20_device pcm20_unit = {
>>-       freq:   87*16000,
>>-       muted:  1,
>>-       stereo: 0
>>+       .freq   = 87*16000,
>>+       .muted  = 1,
>>};
> 
> ...
> 
> IMHO it is not a good idea to skip default initilised members. IT is self
> documenting to see all members, and it is easier to change them, if
> required. Especially if the old code had it.


I think you are half-right :)

It is personal preference whether or not to list default initialized 
members.  However -- if the previous code [like the code above] 
initialized all its members specifically, then the C99 initializers 
cleanup should not change that practice.

	Jeff



