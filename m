Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTCJP65>; Mon, 10 Mar 2003 10:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTCJP65>; Mon, 10 Mar 2003 10:58:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261339AbTCJP64>;
	Mon, 10 Mar 2003 10:58:56 -0500
Date: Mon, 10 Mar 2003 09:45:12 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Ben Collins <bcollins@debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Device removal callback
In-Reply-To: <20030309181413.GA492@phunnypharm.org>
Message-ID: <Pine.LNX.4.33.0303100939001.1002-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, here's my simple patch. I'd really like this to be applied to the
> proper kernel. I really can't see how the driver model is working
> without walking children on unregister, but this atleast allows you to
> handle it yourself.

The assumption is that the bus driver will take care of cleaning up all 
the children before unregistering the parent. This place a bit more 
responsibility on the bus driver, but it keeps it simple in the core. 

That's not to say that it can't change in the future, but I don't want to 
take that step right now. There are a lot of implications WRT locking and 
recursion that need to be worked out, and I'd rather wait on making these 
kind of core changes.


	-pat

