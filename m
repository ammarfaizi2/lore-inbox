Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270503AbTGNC6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270504AbTGNC6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:58:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:5269 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270503AbTGNC6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:58:38 -0400
Date: Mon, 14 Jul 2003 04:12:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714031242.GC23110@mail.jlokier.co.uk>
References: <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com> <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com> <20030714025644.GA23110@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714025644.GA23110@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 	(e) there is urgent data with OOBINLINE (I think)

To be more precise, using the POLLRDHUP patch as-is, if someone sends
your program some data, then an URGent segment, then a FIN with
optional data in between, your program won't notice the second data or
FIN and will fail to clean up the socket.

-- Jamie
