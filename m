Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270056AbTGMAvF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 20:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270058AbTGMAvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 20:51:05 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:36006 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S270056AbTGMAvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 20:51:03 -0400
Date: Sat, 12 Jul 2003 20:05:47 -0500
From: Eric Varsanyi <e0206@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030713010547.GB18203@srv.foo21.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk> <20030712205114.GC15643@srv.foo21.com> <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com> <20030712211941.GD15643@srv.foo21.com> <Pine.LNX.4.55.0307121436460.4720@bigblue.dev.mcafeelabs.com> <20030712231147.GI15643@srv.foo21.com> <Pine.LNX.4.55.0307121653550.4720@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307121653550.4720@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > read(), returns 0 right away		socket buffer is empty
> 
> read will return -1 with errno=EAGAIN in that case, not zero.

Yes, my mistake. So the real issue (of the patch) is just the original
thing I posted about: you can't tell w/o another read() syscall if an
EOF has piggybacked in on an EPOLLIN event.

Thanks for being patient.

-Eric Varsanyi
