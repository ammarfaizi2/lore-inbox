Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286366AbRLJUBQ>; Mon, 10 Dec 2001 15:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286369AbRLJUBH>; Mon, 10 Dec 2001 15:01:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S286366AbRLJUAu>; Mon, 10 Dec 2001 15:00:50 -0500
Date: Mon, 10 Dec 2001 15:00:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: min-write-size for a UDP socket to be POLLOUT cannot be set. (proposed fixes)
In-Reply-To: <3C151128.5080109@candelatech.com>
Message-ID: <Pine.LNX.3.95.1011210145814.405A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Ben Greear wrote:

> This relates to my earlier question about setting the threshold
> at which select returns that a (UDP) socket is writable.
> 
> It appears that UDP sockets are hardwired at 2048 bytes...
> 
>  From linux/include/net/sock.h:

    int len = 0x8000;

    setsockopt(s, SOL_SOCKET, SO_SNDBUF, &len, sizeof(len));
    setsockopt(s, SOL_SOCKET, SO_RCVBUF, &len, sizeof(len));


Doesn't this work?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


