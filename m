Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318331AbSG3O5k>; Tue, 30 Jul 2002 10:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSG3O5k>; Tue, 30 Jul 2002 10:57:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18816 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318331AbSG3O5j>; Tue, 30 Jul 2002 10:57:39 -0400
Date: Tue, 30 Jul 2002 11:01:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Kerrisk <m.kerrisk@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Weirdness with AF_INET listen() backlog [2.4.18]
In-Reply-To: <7911.1028039755@www55.gmx.net>
Message-ID: <Pine.LNX.3.95.1020730105554.1971A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Michael Kerrisk wrote:

> Gidday,
> 
> First of all, apologies for the length of this message, but hopefully it
> contains all the information necessary to show the problem I'm seeing.
> 
> I'm seeing some puzzling behaviour with the backlog argument to listen()
> with AF_INET sockets on Linux 2.4.18 (SuSE 8.0).
> 
> I had expected that if a server creates a listening socket, but does not
> accept() the incoming connections, then after the (possibly fudge-factored)
> connection limit specified by backlog was reached, further client connect()s
> would block and eventually fail with the error ETIMEDOUT.  (This is the
> behaviour  on other Unices that I'm familiar with.)
>

I think you are running into SYN-flood protection. It's my understanding
that backlog is largely ignored now-days.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

