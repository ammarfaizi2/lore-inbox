Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310359AbSCLCtv>; Mon, 11 Mar 2002 21:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310363AbSCLCtl>; Mon, 11 Mar 2002 21:49:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13324 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310359AbSCLCt1>;
	Mon, 11 Mar 2002 21:49:27 -0500
Message-ID: <3C8D6CA4.8060604@mandrakesoft.com>
Date: Mon, 11 Mar 2002 21:49:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kcTV-0002ar-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Linus, would it be acceptable to you to include an -optional- filter for 
>>ATA commands?  There is definitely a segment of users that would like to 
>>firewall their devices, and I think (as crazy as it may sound) that 
>>notion is a valid one.
>>
>
>Jeff -I like the idea of the filters - but if the ATA command raw stuff
>is CAP_SYS_RAWIO then its the same right set as inb/outb. Beyond that
>its a job for the NSA and RSBAC stuff ?
>
Yeah, you can still bit-bang with the current implementation, on that 
capability.  Couldn't that be cured with s/CAP_SYS_RAWIO/some new 
CAP_DEVICE_CMD/  for the raw device command interface?

The current implementation needs to be changed anyway :)  From "ATA raw 
command" to "device raw command" at the very least.

    Jeff



