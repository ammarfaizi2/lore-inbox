Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSENLYv>; Tue, 14 May 2002 07:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315612AbSENLYu>; Tue, 14 May 2002 07:24:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25867 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315611AbSENLYt>; Tue, 14 May 2002 07:24:49 -0400
Message-ID: <3CE0E538.5040502@evision-ventures.com>
Date: Tue, 14 May 2002 12:21:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Neil Conway <nconway.list@ukaea.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk> <3CE0D067.6010302@evision-ventures.com> <3CE0E306.6171045B@ukaea.org.uk> <3CE0D952.7080403@evision-ventures.com> <3CE0F08A.5C41CAFA@ukaea.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Neil Conway napisa?:
> Martin Dalecki wrote:
> 
>>There is no problem to go in paralell on different channels for
>>requests. The serialization has only to be done
>>for the drive setup.
> 
> 
> I agree for general chipsets, but my whole point was with regard to
> buggy chipsets which need to be serialized on both channels.
> 
> If you're saying that even these broken chipsets are OK with having
> transfers on one channel while setting up transfers on another channel,
> then perhaps you are right but that's not what I believed to be the case
> (can't find info to tell me either way right now).
> 
> But if that really were the case, then how could the (e.g.) cmd640
> problem ever have been manifested?  A spinlock is ALWAYS held while
> ide_do_request is executing.  Even if it weren't, only an SMP machine
> could be trying to program both channels simultaneously because
> interrupts are disabled too.


Well in the next patch round the hwgroup will be replaced with
a spin lock, which is supposed to be shared between channels which need
forced access serialization between them. Please look
at patches 62a and 63 :-).


