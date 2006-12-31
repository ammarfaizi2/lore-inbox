Return-Path: <linux-kernel-owner+w=401wt.eu-S933124AbWLaKtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933124AbWLaKtT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 05:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933126AbWLaKtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 05:49:19 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55022
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933124AbWLaKtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 05:49:18 -0500
Date: Sun, 31 Dec 2006 02:49:17 -0800 (PST)
Message-Id: <20061231.024917.59652177.davem@davemloft.net>
To: dmk@flex.com
Cc: wmb@firmworks.com, devel@laptop.org, linux-kernel@vger.kernel.org,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <45978CE9.7090700@flex.com>
References: <20061230.211941.74748799.davem@davemloft.net>
	<459784AD.1010308@firmworks.com>
	<45978CE9.7090700@flex.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Kahn <dmk@flex.com>
Date: Sun, 31 Dec 2006 02:11:53 -0800

> All we've done is created a trivial implementation for exporting
> the device tree to userland that isn't burdened by the powerpc
> and sparc legacy code that's in there now.

So now we'll have _3_ different implementations of exporting
the OFW device tree via procfs.  Your's, the proc_devtree
of powerpc, and sparc's /proc/openprom

That doesn't make any sense to me, having 3 ways of doing the same
exact thing and making no attempt to share code at all.

If you want to do something new that consolidates everything, with the
goal of deprecating the existing stuff, that's great!  But with they
way you're doing this, all the sparc and powerpc implementations
really can't take advantage of it.

Am I the only person who sees something very wrong with this?
