Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315590AbSENJ4H>; Tue, 14 May 2002 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315591AbSENJ4G>; Tue, 14 May 2002 05:56:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:27658 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315590AbSENJ4F>; Tue, 14 May 2002 05:56:05 -0400
Message-ID: <3CE0D067.6010302@evision-ventures.com>
Date: Tue, 14 May 2002 10:52:55 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Neil Conway <nconway.list@ukaea.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Neil Conway napisa?:
> Hi...  Please correct me if I'm wrong but:
> 
> I think this patch is broken wrt serialization of channels on buggy
> chipsets.
> 
> The hwgroup was serialized so that in certain cases, it can contain BOTH
> channels, and thus only one channel is active at a time (e.g. cmd640). 
> With this patch, you are now serializing only channels, not hwgroups
> (which makes hwgroup totally redundant, yes?), and I can't see which bit
> of your patch protects the chipsets that need both channels to be
> serialized.
> 
> I think I see where you're going with the cleanup (and this isn't
> unrelated to the conversation about IDE-62) but as it stands, this patch
> will IMHO totally fsck any machines with dodgy chipsets.
> 
> Neil

No it will not, since we act serialized on ide_lock anyway.
However I have right now per channel (or serialization group)
lock running right now / modulo locking order problems.


