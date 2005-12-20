Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVLTXBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVLTXBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVLTXBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:01:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:4751 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932170AbVLTXBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:01:10 -0500
Subject: Re: sungem hangs in atomic if netconsole enabled but no carrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Eric Lemoine <eric.lemoine@gmail.com>
In-Reply-To: <20051220221906.GB2525@electric-eye.fr.zoreil.com>
References: <1135080538.3937.3.camel@localhost>
	 <20051220221906.GB2525@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 09:59:14 +1100
Message-Id: <1135119554.10035.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 23:19 +0100, Francois Romieu wrote:

> net/core/netpoll.c::netpoll_send_skb() notices that the queue is stopped
> and decides to try the usual NAPI poll(). A few function calls later, the
> driver ends in drivers/net/sungem.c::gem_poll() where it takes so many
> (irq-)locks that I do not even want to verify that it has a chance
> to play nice with the pending gem_link_timer().

I'm not fan of the locking in sungem, I think I wrote a big fat comment
about it and why it is like that for now, better ideas are welcome :)

Ben.


