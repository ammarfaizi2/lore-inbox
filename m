Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSKMS2o>; Wed, 13 Nov 2002 13:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSKMS2o>; Wed, 13 Nov 2002 13:28:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48516 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262387AbSKMS2n>; Wed, 13 Nov 2002 13:28:43 -0500
Date: Wed, 13 Nov 2002 13:38:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Chuck Lever <cel@citi.umich.edu>, Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <shsd6p9mn39.fsf@charged.uio.no>
Message-ID: <Pine.LNX.3.95.1021113133354.2518B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2002, Trond Myklebust wrote:

> >>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:
> 
>      > If the application "chooses to drop the request", the kernel is
>      > not required to fix that application. The RPC cannot retransmit
>      > if it has been shut-down or disconnected, which is about the
>      > only way the application could "choose to drop the request". So
>      > something doesn't smell right here.
> 
> An NFS server is perfectly free to drop an RPC request if it doesn't
> have the necessary free resources to service it (i.e. if it is out of
> memory). If the client doesn't time out + retry, you lose data. Not a
> good idea...
> 
> Cheers,
>   Trond

The Client is the guy that just retries, as you say from a time-out.
This shouldn't affect any internal TCP/IP code. The time-out is
at the application (client) level. It sent a request, the data
was sent or promised to be sent because the write() or send() didn't
block, now it expects to get the data it asked for. It waits, nothing
happens. It times-out and sends the exact same request again.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


