Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282878AbRLGSdk>; Fri, 7 Dec 2001 13:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284298AbRLGSda>; Fri, 7 Dec 2001 13:33:30 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:58498 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S282878AbRLGSd1>; Fri, 7 Dec 2001 13:33:27 -0500
Message-ID: <3C110B6C.9070709@antefacto.com>
Date: Fri, 07 Dec 2001 18:33:16 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de> <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com> <20011207185847.A20876@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>You can be thread-safe without sucking dead baby donkeys through a straw.
>>I already mentioned two possible ways to fix it so that you have locking
>>when you need to, and no locking when you don't.
>>
> 
> Your proposals sound rather dangerous. They would silently break recompiled
> threaded programs that need the locking and don't use -D__REENTRANT (most
> people do not seem to use it).


I would worry about threaded progs that don't -D_REENTRANT as
they are broken.

> I doubt the possible pain from that is 
> worth it for speeding up an basically obsolete interface like putc. 
> 
> i.e. if someone wants speed they definitely shouldn't use putc()

It's not just putc, it's all of stdio.

Padraig.

