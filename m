Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUEENOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUEENOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEENMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:12:23 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:16658 "EHLO
	mwinf1003.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264647AbUEENKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:10:10 -0400
Date: Wed, 5 May 2004 15:10:06 +0200
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ne2k-pci uncorrectly detecting collisions ?
Message-ID: <20040505131006.GA3412@blop.info>
References: <20040505123532.GA3011@blop.info> <Pine.LNX.4.53.0405050855290.16355@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0405050855290.16355@chaos>
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 09:00:50AM -0400, "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > I have experienced problem with the ne2k-pci driver. The symptoms were
> > extremly poor performance with TCP. After some investigations, I believe
> > it might be caused by problems with detecting collisions.
> >
> 
> But software doesn't detect collisions. It just records what
> hardware said it did. It looks like you have a 10 Mb/s card
> on a 100 Mb/s network. The collisions reported are how the
> hardware throttles the difference in physical-link speed.

The hub is a 10/100 one, and the 3 RTL8029 are 10 Mbps only.

> It is possible that software didn't initialize a 100 Mb/s
> device and instead initialized it to 10 Mb/s, but you
> don't have any evidence of that presented.

No, because RTL8029 are 10 mbps only (they are BNC/RJ45 NICs).

But what I thought was that maybe, they were initialised as full duplex,
not half duplex. But again, I don't know where I can check that. I added
some printks and determined that the code used to init them full duplex
was never used. And there's no way to force them half duplex with this
driver.

Lucas
