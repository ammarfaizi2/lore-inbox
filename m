Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbSIXUNz>; Tue, 24 Sep 2002 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbSIXUNz>; Tue, 24 Sep 2002 16:13:55 -0400
Received: from mail.webmaster.com ([216.152.64.131]:23170 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S261768AbSIXUNy> convert rfc822-to-8bit; Tue, 24 Sep 2002 16:13:54 -0400
From: David Schwartz <davids@webmaster.com>
To: <pwaechtler@mac.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Tue, 24 Sep 2002 13:19:06 -0700
In-Reply-To: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020924201908.AAA16336@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The effect of M:N on UP systems should be even more clear. Your
>multithreaded apps can't profit of parallelism but they do not
>add load to the system scheduler. The drawback: more syscalls
>(I think about removing the need for
>flags=fcntl(GETFLAGS);fcntl(fd,NONBLOCK);write(fd);fcntl(fd,flags))

	The main reason I write multithreaded apps for single CPU systems is to 
protect against ambush. Consider, for example, a web server. Someone sends it 
an obscure request that triggers some code that's never run before and has to 
fault in. If my application were single-threaded, no work could be done until 
that page faulted in from disk. This is why select-loop and poll-loop type 
servers are bursty.

	DS


