Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132607AbQKWGo5>; Thu, 23 Nov 2000 01:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132615AbQKWGor>; Thu, 23 Nov 2000 01:44:47 -0500
Received: from smtp2.free.fr ([212.27.32.6]:14353 "EHLO smtp2.free.fr")
        by vger.kernel.org with ESMTP id <S132607AbQKWGog>;
        Thu, 23 Nov 2000 01:44:36 -0500
To: kuznet@ms2.inr.ac.ru
Subject: Re: [BUG] 2.2.1[78] : RTNETLINK lock not properly locking ?
Message-ID: <974960072.3a1cb5c821d96@imp.free.fr>
Date: Thu, 23 Nov 2000 07:14:32 +0100 (MET)
From: Willy Tarreau <willy.lkml@free.fr>
Cc: Willy Tarreau <willy.LKml@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <200011221809.VAA20851@ms2.inr.ac.ru>
In-Reply-To: <200011221809.VAA20851@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.48.151
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is linux-2.2, guy. 8) "threads" are not threaded there.
> 
> Semaphores (rtnl_lock, particularly) protects only areas, which
> are going to _schedule_ excplicitly or implicitly.

ok, thanks a lot Alexey, now I understand.

> Please, read comments. People used to consider comments as something
> decorative, but they are not. 

I did read them again and again, but you know, when there's something
you don't understand, sometimes you interprete things badly.

> Any questions?
not anymore, of course :-)

> Sorry...
> 
> /* NOTE: these locks are not interrupt safe, are not SMP safe,
>  * they are even not atomic. 8)8)8) ... and it is not a bug.
> etc.
> 
> Do you call this "very precautios"? 8)

I spoke about the first ones :)

thanks a lot, now I know how to proceed.

Cheers,
Willy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
