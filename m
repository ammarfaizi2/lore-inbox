Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270121AbTGUOVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270122AbTGUOVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:21:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28035 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270121AbTGUOVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:21:34 -0400
Date: Mon, 21 Jul 2003 10:38:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar \"Philips\" Filipau" <ifilipau@giga-stream.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: SVR4 STREAMS (for example LiS)
In-Reply-To: <3F1BF509.1000608@giga-stream.de>
Message-ID: <Pine.LNX.4.53.0307211031460.18968@chaos>
References: <3F1BF509.1000608@giga-stream.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003, Ihar "Philips" Filipau wrote:

> Hello All!
>
>     I have little bit theoretical question. As usual ;-)
>
>     From what ever piece of doc I see says that STREAMS are good.
>     They are part of SUS (at least v3 has them).
>     Sun's docs reffering only cases when one may want to use them.
>     This was the first pointer to problems: docs are missing the
>        "dark side" of STREAMS.
>
>     Can anyone give any pointers to information why STREAMS are _not_
>        part of Linux kernel yet?
>     (Besides that no-one needs/merged it in kernel ;-)
>     What kind of problems this implementation of I/O has?
>     (Low performance and high latencies I expect - but what's else?)
>
>     Any sort of RTFM will be very appreciated.
>
>     Thanks in advance.
>

Streams are an extension of buffered I/O implimented by the 'C'
runtime library. Streams really have nothing to do with the
internal workings of kernel I/O. As far as kernel I/O goes,
one reads() and writes() from user-space.

That said, the kernel provides getpmsg and putpmsg functions
to support streams. You really can't do much more for streams
inside the kernel and be efficient.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

