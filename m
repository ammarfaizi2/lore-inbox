Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVI0DGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVI0DGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVI0DGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:06:12 -0400
Received: from xenotime.net ([66.160.160.81]:17595 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750819AbVI0DGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:06:11 -0400
Date: Mon, 26 Sep 2005 20:06:08 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Readahead
Message-Id: <20050926200608.7fe0ff89.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.44L0.0509262234500.32418-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0509262234500.32418-100000@netrider.rowland.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005 22:38:21 -0400 (EDT) Alan Stern wrote:

> Can somebody please tell me where the code is that performs optimistic
> readahead when a process does sequential reads on a block device?

There's filesystem readahead in fs/buffer.c (__breadahead()),
although I don't see any actual callers of it.

However, I'm guessing that you are actually thinking about the
anticipatory IO scheduler (as), which is found in
drivers/block/as-iosched.c.
drivers/block/ll_rw_blk.c also does some readahead (READA) work.

> And can someone explain why those readahead calls are allowed to extend 
> beyond the end of the device?

Nope.

---
~Randy
