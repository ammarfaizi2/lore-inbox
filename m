Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSENLwW>; Tue, 14 May 2002 07:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315625AbSENLwV>; Tue, 14 May 2002 07:52:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47371 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315619AbSENLwU>; Tue, 14 May 2002 07:52:20 -0400
Message-ID: <3CE0EBAB.4060705@evision-ventures.com>
Date: Tue, 14 May 2002 12:49:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk> <3CE0D067.6010302@evision-ventures.com> <3CE0E306.6171045B@ukaea.org.uk> <3CE0D952.7080403@evision-ventures.com> <3CE0F08A.5C41CAFA@ukaea.org.uk> <3CE0E538.5040502@evision-ventures.com> <20020514123830.A18118@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Tue, May 14, 2002 at 12:21:44PM +0200, Martin Dalecki wrote:
> 
>>Well in the next patch round the hwgroup will be replaced with
>>a spin lock, which is supposed to be shared between channels which need
>>forced access serialization between them. Please look
>>at patches 62a and 63 :-).
> 
> 
> Something here smells fishy here - you shouldn't hold a spinlock for a long
> time (a long time === spinlocking, setting up the drive, possibly scheduling,
> transferring data, getting status, then unlocking).  Also, remember,
> spinlocks are no-ops on uniprocessor systems.

Well, let's just have a look at how to share request queues between
channels which need this treatment in addition then?

