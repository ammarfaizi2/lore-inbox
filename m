Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSFLXVT>; Wed, 12 Jun 2002 19:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317372AbSFLXVS>; Wed, 12 Jun 2002 19:21:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317371AbSFLXVR>;
	Wed, 12 Jun 2002 19:21:17 -0400
Message-ID: <3D07D6A6.7090308@mandrakesoft.com>
Date: Wed, 12 Jun 2002 19:17:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, saw@saw.sw.com.sg,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: NAPI for eepro100
In-Reply-To: <3D0740ED.2060907@ict.ac.cn>	<3D07D270.5060902@mandrakesoft.com> <20020612.160532.134201977.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Wed, 12 Jun 2002 19:00:00 -0400
>    
>    for the 'mips' patch, it looks 
>    like the arch maintainer(s) need to fix the PCI DMA support...
> 
> No, it's worse than that.
> 
> See how non-consistent memory is used by the eepro100 driver
> for descriptor bits?  The skb->tail bits?
> 
> That is very problematic.


Oh crap, you're right...   eepro100 in general does funky stuff with the 
way packets are handled, mainly due to the need to issue commands to the 
NIC engine instead of the normal per-descriptor owner bit way of doing 
things.

Well, I accept patches to that clean eepro100 up...   I'm not terribly 
motivated to clean it up myself, as we have e100 and an e100 maintainer 
we can beat on if such uglies arise :)

	Jeff



