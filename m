Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932359AbWFEBBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWFEBBU (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWFEBBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:01:20 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38623 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932359AbWFEBBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:01:19 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Jun 2006 18:01:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Willy TARREAU <willy@w.ods.org>
cc: Andrew Morton <akpm@osdl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjan Van de Ven <arjan@infradead.org>
Subject: Re: [patch] epoll use unlocked wqueue operations ...
In-Reply-To: <20060604205258.GA311@w.ods.org>
Message-ID: <Pine.LNX.4.64.0606041800100.27304@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0606021600001.5402@alien.or.mcafeemobile.com>
 <20060603060438.GB30150@w.ods.org> <Pine.LNX.4.64.0606031031030.17149@alien.or.mcafeemobile.com>
 <20060604205258.GA311@w.ods.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006, Willy TARREAU wrote:

>> Well, we take a lock less but I can't say if it'll be measureable. The
>> test program above is not a performance thing though, just some code to
>> verify multiple threads doing waits on the same epoll fd.
>
> OK, so I ported your patch to 2.4 (+epoll-lt-0.22) because I have some
> code using it right there. At first, I thought I was observing measuring
> errors, but after about 6 reboots, I seem to observe a consistent 6.5%
> increase in the number of sessions/s on my fake web server on my dual
> athlon. It jumps from 14350 hits/s with epoll-lt-0.22 alone to 15300 with
> your patch. It seems much to me, but I'm sure I'm not dreaming (yet).

Ok, that's measureable :)


> I'll send you (offlist) an update to 2.4-epoll-lt-0.22 which incorporates
> this patch.

Thx for the patch. Got it and uploaded.


- Davide


