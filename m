Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbSL3KoG>; Mon, 30 Dec 2002 05:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSL3KoG>; Mon, 30 Dec 2002 05:44:06 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:5286 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S266859AbSL3KoF>; Mon, 30 Dec 2002 05:44:05 -0500
Date: Mon, 30 Dec 2002 11:52:15 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EINTR
Message-ID: <20021230105215.GA26221@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <007301c2aeca$193892c0$3640a8c0@boemboem>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007301c2aeca$193892c0$3640a8c0@boemboem>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden, Sun, Dec 29, 2002 00:37:34 +0100:
> Hi,
> 
> I always thought: you should always check for errno==EINTR when doing
> read/write/recv/recvfrom/sendto.
> But today I heard that when using Linux, EINTR does NEVER occur when
> doing read/etc. on files.
> Is this true?

It was definitely true for 2.4.9.
Even on NFS mounted files.
What happen if the volumes mounted with intr, btw?

> And also: is this also true for sockets? and recv & friends?

No. You _have_to_ check EINTR for sockets, fifos, and pipes.

-alex
