Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284321AbRLGSl7>; Fri, 7 Dec 2001 13:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284322AbRLGSlu>; Fri, 7 Dec 2001 13:41:50 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:10115 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S284321AbRLGSld>; Fri, 7 Dec 2001 13:41:33 -0500
Message-ID: <3C110D57.3050409@antefacto.com>
Date: Fri, 07 Dec 2001 18:41:27 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <Pine.LNX.4.33.0112071013390.8465-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Fri, 7 Dec 2001, Andi Kleen wrote:
> 
>>Your proposals sound rather dangerous. They would silently break recompiled
>>threaded programs that need the locking and don't use -D__REENTRANT
>>
> 
> No it wouldn't.
> 
> Once you do a pthread_create(), the locking is there.
> 
> Before you do a pthread_create(), it doesn't lock.
> 
> What's the problem? Before you do a pthread_create(), you don't _NEED_
> locking, because there is only one thread that accesses the stdio data
> structures.
> 
> And there are no races - if there is only one thread, then another thread
> couldn't be suddenly doing a pthread_create() during a stdio operations.
> 
> Safe, and efficient. Yes, it adds a flag test or a indirect branch, but
> considering that you avoid a serialized locking instruction, the
> optimization sounds obvious.
> 
> 		Linus



