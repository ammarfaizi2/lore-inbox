Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314343AbSEIUyu>; Thu, 9 May 2002 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314351AbSEIUyt>; Thu, 9 May 2002 16:54:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:24069 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314343AbSEIUyt>; Thu, 9 May 2002 16:54:49 -0400
Message-ID: <3CDAD35A.6070900@evision-ventures.com>
Date: Thu, 09 May 2002 21:51:54 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH & call for help: Marking ISA only drivers
In-Reply-To: <20020509203719.A3746@averell>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Andi Kleen napisa?:
> Hallo,
> 
> This patch tries to make most ISA only drivers dependent on CONFIG_ISA. 

If only for the fact that it allows you to don't look at archaic
hardware configuration options makes it a good idea I think.
Bus is bus if we have CONFIG_PCI, we should have CONFIG_ISA as well.

> The motivation is that it is a lot of work to get old drivers to compile
> meaningfully (at least without warnings, not even testing them) on x86-64
> and a lot of them are obviously not 64bit safe.  As it is very unlikely
> that x86-64 boxes will ever have ISA slots[1] one simple way for that
> is just removing the old ISA drivers from the configuration.
> 
> BTW I think CONFIG_ISA would be an useful configuration option for 
> i386 too - at least most modern PCs do not come with ISA slots anymore.

Plase add mcd and mcdx - CD-ROM drivers. Both of them required
an special "controller" card, which was indeed ISA based.

