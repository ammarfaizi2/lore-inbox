Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313049AbSC0Qm1>; Wed, 27 Mar 2002 11:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313052AbSC0QmR>; Wed, 27 Mar 2002 11:42:17 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53252 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313049AbSC0QmF>; Wed, 27 Mar 2002 11:42:05 -0500
Message-ID: <3CA1F5ED.2060203@evision-ventures.com>
Date: Wed, 27 Mar 2002 17:40:13 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.5.7.fix2.patch
In-Reply-To: <5.1.0.14.2.20020327154219.05069c30@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> Hi Andre,
> 
> I tried this patch on my laptop to see if it would make my atapi cdrom 
> data underrun problems go away.
> 
> Unfortunately booting 2.5.7 + your patch causes hda: lost interrupt 
> messages to appear. It still manages to progress through the boot 
> scripts ok for a while, albeit very, very slowly, but eventually after 
> several lost interrupt messages the kernel crashes.

I can see the same. This is due to the hossed timeout handling
and choose_drive in the current state. If I can finally find
it, please expect me to release the next slew of patches.

> Vanilla 2.5.7 boots fine but the cdrom doesn't work due to the 
> data/buffer underruns...
> 
> I am quite happy to help debug this, let me know what info you would 
> like to see... Can I enable debugging somewhere to get more interesting 
> messages or should I try anything?

Could you tell me whatever the problematic interface is
maybe sharing the IRQ between two IDE channels?
If not. Could you test out whatever the problem remains if
you set the unmask IRQ flag with hdparm?



