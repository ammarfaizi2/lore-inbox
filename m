Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293658AbSCKJ5M>; Mon, 11 Mar 2002 04:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293662AbSCKJ5D>; Mon, 11 Mar 2002 04:57:03 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:60621 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S293658AbSCKJ4o>; Mon, 11 Mar 2002 04:56:44 -0500
From: <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ed Tomlinson <tomlins@cam.org>
Cc: <linux-kernel@vger.kernel.org>, Hank Yang <hanky@promise.com.tw>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Mon, 11 Mar 2002 10:56:25 +0100
Message-Id: <20020311095625.20669@mailhost.mipsys.com>
In-Reply-To: <E16k4be-0006dG-00@the-village.bc.nu>
In-Reply-To: <E16k4be-0006dG-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Second.  There seems to be problems with the ide reset code in pre2-ac2. 
>> I get the following:
>> 
>> hde: timeout waiting for DMA
>> PDC202XX: Primary channel reset.
>> hde: ide_dma_timeout: Lets do it again!stat = 0x50, dma_stat = 0x20
>> hde: DMA disabled
>> PDC202XX: Primary channel reset.
>> hde: ide_set_handler: handler not null; old=c018eeb0, new=c0193de4
>> bug: kernel timer added twice at c018ed31.
>> hde: dma_intr: status=0xd0 { Busy }
>> hde: DMA disabled
>
>Yep. You turned on some of the experimental stuff. It doesnt always recover
>Hopefully the patches from Promise will help there

There is a bug in the DMA timeout recovery code (in the generic code). Andre
and I have been discussing that recently, I'm supposed to come up with a patch
rsn though if Andre doesn't beat me in that race ;) In the meantime, make sure
you don't enable that option in the kernel config.

Ben.


