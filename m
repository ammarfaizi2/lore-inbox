Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270511AbTGNDNY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270512AbTGNDNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:13:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8597 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270511AbTGNDNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:13:23 -0400
Date: Mon, 14 Jul 2003 04:27:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half closed TCP connections)
Message-ID: <20030714032727.GA23534@mail.jlokier.co.uk>
References: <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com> <20030713191559.GA20573@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com> <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk> <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com> <20030714030437.GB23110@mail.jlokier.co.uk> <Pine.LNX.4.55.0307132006420.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307132006420.15022@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> And the name READONCE seems to imply that you can't read(2) twice.

Like all POLL* flags, you can always do more than it implies and get EAGAIN :)

I don't care about the name, feel free to pick another.

> I'd rather prefer the RDHUP flag that tells me : There's an hungup
> condition for sure, and you might also find some data since POLLIN is set.

Yeah, but it doesn't stop the do-while loop from being broken :)

-- Jamie
