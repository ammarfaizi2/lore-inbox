Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTJHPFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTJHPFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:05:38 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:59347 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S261649AbTJHPFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:05:33 -0400
Date: Wed, 08 Oct 2003 17:05:16 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <Pine.LNX.4.53.0310071349560.19396@montezuma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200310081705.16241.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <200310070949.31220.domen@coderock.org>
 <Pine.LNX.4.53.0310071349560.19396@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of October 2003 01:43, Zwane Mwaikambo wrote:
> On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > What is your link peer?
> >
> > Not native english speaker, but if "link peer"  is the remote end, then
> > this is a friend's computer. (and a hub is between computers)
>
> Ok in this case it would be the hub, sometimes these aren't the best when
> it comes to advertising capabilities.

Also slow on crossover cable, without hub.


> > # strace mii-tool eth0
> > execve("/sbin/mii-tool", ["mii-tool", "eth0"], [/* 37 vars */]) = 0
> > socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 3
> > ioctl(3, 0x89f0, 0x804b460)             = -1 EOPNOTSUPP (Operation not
> > supported) write(2, "SIOCGMIIPHY on \'eth0\' failed: Op"...,
> > 54SIOCGMIIPHY on 'eth0' failed: Operation not supported ) = 54
> > close(3)                                = 0
>
> Could you try updating your mii-tool please.

Ok, updated to the one that ships with redhat.
Now i get:
eth0: link ok
when it is slow (-test2 module)

and:
eth0: negotiated 100baseTx-FD, link ok
when it is ok (reloaded -test2 module)

