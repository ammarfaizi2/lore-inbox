Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSG3Jr3>; Tue, 30 Jul 2002 05:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSG3Jr3>; Tue, 30 Jul 2002 05:47:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21775 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316586AbSG3Jr3>; Tue, 30 Jul 2002 05:47:29 -0400
Message-ID: <3D46604E.8050403@evision.ag>
Date: Tue, 30 Jul 2002 11:45:50 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.29 IDE 108
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>	 <3D459710.3020405@evision.ag> <1028026934.6726.16.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-07-29 at 20:27, Marcin Dalecki wrote:
> 
>>- Fixup cmd640 fix by LT.
> 
> 
> The CMD640 fix is wrong. You must take pci_lock to protected the cmd640
> pci access functions. You also need to check if conf1/conf2 is available
> otherwise you will crash some systems when the driver init runs (found
> by Justin Gibbs at Adaptec). I sent Linus the proper patch for this a
> few days ago and cc'd the list.
> 
> Basically conf1/conf2 is protected elsewhere in the kernel via arch
> specific locks and via a higher level config lock. Since the non x86
> folks use CMD640 we have to take the higher level lock.

Yes I know. However I see the bk-tree drifting and therefore I have
postponed the integration of your patch a bit. The chunk above I did
immediately after 2.5.29 release. Hope this explains. OK?

