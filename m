Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266939AbTGOJOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266945AbTGOJOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:14:42 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:21985 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S266939AbTGOJOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:14:39 -0400
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 15 Jul 2003 10:24:13 +0100
MIME-Version: 1.0
Subject: Re: PPC 440 System
Message-ID: <3F13D64D.12715.E1BA3@localhost>
In-reply-to: <524r1pw0bd.fsf@topspin.com>
References: <3F12A1B9.3086.614B56@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand. Can I not just use the math emulation in the kernel ?

Cheers

Simon.

On 14 Jul 2003 at 9:16, Roland Dreier wrote:

>     simon> If I remove /sbin/init from the nfs root the kernel panics
>     simon> as expected, so I assume root is mounted ok. I have tried
>     simon> to build a minimum root filesystem which contains
>     simon> /dev/console, /dev/ttyS0 and a statically linked
>     simon> /sbin/init. The init just does a printf but I do not see
>     simon> this message. Does anyone know it this should work ?
> 
> Yes, a static /sbin/init should work.
> 
>     simon> Initially I tried to build a root filesystem from files on
>     simon> a Mac Clone running Yellow Dog Linux. I believe this has a
>     simon> PPC 604e processor. Should this systems binaries/libraries
>     simon> run on the 440GP ?
> 
>     simon> Can I expect a statically linked executable, made on the
>     simon> Mac, to run on the 440GP?
> 
> Probably not.  The 440GP has no floating point hardware, so you will
> need (at least) to build a special glibc without FP instructions and
> also make sure your gcc is set up not to generate FP instructions.
> 
> Your best bet is probably to download ELDK (a free Embedded Linux
> Development Kit) from www.denx.de.  Dan Kegel also has some good PPC
> 4xx cross development information at www.kegel.com.
> 
> Best,
>   Roland
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________

