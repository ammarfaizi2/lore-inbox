Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292883AbSBVOsg>; Fri, 22 Feb 2002 09:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292884AbSBVOs0>; Fri, 22 Feb 2002 09:48:26 -0500
Received: from [195.63.194.11] ([195.63.194.11]:19978 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292883AbSBVOsJ>; Fri, 22 Feb 2002 09:48:09 -0500
Message-ID: <3C765A02.7040302@evision-ventures.com>
Date: Fri, 22 Feb 2002 15:47:30 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Gadi Oxman <gadio@netvision.net.il>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C723B15.2030409@evision-ventures.com> <00a201c1bb8d$90dd2740$0300a8c0@lemon> <3C764B7C.2000609@evision-ventures.com> <20020222150323.A5530@suse.cz> <3C7652B6.1040008@evision-ventures.com> <20020222153806.A5783@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> I don't think so. If needed we can make some generic IDE_QUIRK_XXX
> defines which then the chipset drivers can use where applicable, passing
> them to the generic code.

I just noticed that you are *right*. I'm going over the whole recognized
PCI device list anyway, so I will just add a flag field to the struct 
ide_pci_device_s. There are at least fortunately not more then 32
different quirk types ;-).
And then the whole she-bag can be really pushed down to the
particular chipset setup file indeed.

