Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269471AbRHQCkd>; Thu, 16 Aug 2001 22:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269489AbRHQCkX>; Thu, 16 Aug 2001 22:40:23 -0400
Received: from mail.webmaster.com ([216.152.64.131]:65444 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S269465AbRHQCkM>; Thu, 16 Aug 2001 22:40:12 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Kalpesh Shah" <kalpesh@cs.utexas.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: Socket options
Date: Thu, 16 Aug 2001 19:40:23 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMIEPIDDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.GSO.4.33.0108162055050.24575-100000@cabaco.cs.utexas.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would like to be CC'ed any answers/comments to my question.
>
> are /proc/sys/net/ipv4/tcp_rmem and /proc/sys/net/ipv4/tcp_wmem the socket
> Buffer (receive and send respectively) Sizes in the linux kernel.
>
> If yes then how come when I try to set these buffer sizes by using the
> SO_RCVBUFF and SO_SNDBUFF variables it automatically multiplies the values
> by 2 ????
>
> -kalpesh

	The kernel is trying to give you what it thinks you want. The general idea
behind setting these buffers is that you want about that many actual bytes
of data from the stream to be buffered. But the memory is used for things
other than stream data. So to try to give it room for, say 10Kb of stream
data, it allocates 20Kb of memory.

	DS

