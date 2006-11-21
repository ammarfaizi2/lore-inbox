Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934336AbWKUGNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934336AbWKUGNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934337AbWKUGNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:13:31 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43753
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S934336AbWKUGNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:13:31 -0500
Date: Mon, 20 Nov 2006 22:13:29 -0800 (PST)
Message-Id: <20061120.221329.74747650.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: bus_id collisions
From: David Miller <davem@davemloft.net>
In-Reply-To: <1164081736.8207.14.camel@localhost.localdomain>
References: <1164081736.8207.14.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 21 Nov 2006 15:02:16 +1100

> This has caused me some trouble with of_platform devices, which are
> sort-of platform devices but linked to the Open Firmware device-tree, as
> I generate their names based on the nodes in the tree which need not be
> unique as long as they are unique under a given parent.
> 
> I've worked around it, but I though the comment might need to be
> clarified.

BTW Ben, on sparc64 for of devices I use "%08x" and the PROM
node ID as the bus_id[] to deal with this.
