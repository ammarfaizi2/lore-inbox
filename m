Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbTGNCmm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270500AbTGNCmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:42:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:1685 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270499AbTGNCml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:42:41 -0400
Date: Mon, 14 Jul 2003 03:56:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714025644.GA23110@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com> <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com> <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Where this will break by using a POLLRDHUP ?

It will break if

	(a) fd isn't a socket
	(b) fd isn't a TCP socket
	(c) kernel version <= 2.5.75
	(d) SO_RCVLOWAT < s
	(e) there is urgent data with OOBINLINE (I think)

-- Jamie
