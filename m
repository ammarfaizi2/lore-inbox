Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQJaC3p>; Mon, 30 Oct 2000 21:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129817AbQJaC3Z>; Mon, 30 Oct 2000 21:29:25 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:59403 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129789AbQJaC3Q>;
	Mon, 30 Oct 2000 21:29:16 -0500
Message-Id: <200010310229.e9V2TCF29473@sleipnir.valparaiso.cl>
To: Riley Williams <rhw@MemAlpha.CX>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.X patch query 
In-Reply-To: Message from Riley Williams <rhw@MemAlpha.CX> 
   of "Mon, 30 Oct 2000 20:01:32 -0000." <Pine.LNX.4.10.10010301935480.10495-100000@infradead.org> 
Date: Mon, 30 Oct 2000 23:29:12 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.CX> said:

[...]

> Before I go any further with this, I would like to ask a few questions
> relating to it:
> 
>  1. Is there any likelihood of this making it into the official
>     kernel, or am I just wasting my time?

Depends, I'd say... perhaps after a long shakeout and much use.

>  2. Would I be right in thinking it's too late for either the
>     2.2 or 2.4 kernels ???

No way.

> Assuming it'd be of interest to Linus and yourself...

[...]

>  5. I was wondering about providing some means of selecting
>     whether to dump to /dev/fd0 or /dev/fd1 (or others if
>     present). What would be your opinion on this?

Keep it as simple as possible. I'd leave the option open if not hard, but
not implement it at all at first.

>  6. A while back, I developed a high-level floppy formatter
>     that produces a non-standard DOS-compatible format that
>     allows 1436k of data on a 1440k floppy, and produced a
>     bash script that would produce disks formatted in this
>     format.
> 
>     My current plans are for SYSRQ-D to raw write direct to
>     /dev/fd0 and effectively reformat the disks in this
>     format, dropping the log file thereon in the process. I
>     don't plan on doing the low-level format, just the
>     high-level one.

KISS, again. What use is a non-standard 1436Kb DOS format when writing at
most 1Mb? I'd just dump it raw to /dev/fd0, whoever wants to read it later
will have all kinds of tools at hand.

Remember:

- Bloat
- This will have to work even in a thoroughly hosed system to be of any use
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
