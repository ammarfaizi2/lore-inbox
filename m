Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270502AbTGNCz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270503AbTGNCz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:55:29 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:8585 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270502AbTGNCz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:55:28 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 20:02:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half
 closed TCP connections)
In-Reply-To: <20030714025644.GA23110@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307131958120.15022@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com>
 <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
 <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
 <20030713191559.GA20573@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
 <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
 <20030714025644.GA23110@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > Where this will break by using a POLLRDHUP ?
>
> It will break if
>
> 	(a) fd isn't a socket
> 	(b) fd isn't a TCP socket
> 	(c) kernel version <= 2.5.75
> 	(d) SO_RCVLOWAT < s
> 	(e) there is urgent data with OOBINLINE (I think)

Jamie, did you smoke that stuff again ? :)
With Eric patch in the proper places it is just fine. You just make
f_op->poll() to report the extra flag other that POLLIN. What's the problem ?



- Davide

