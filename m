Return-Path: <linux-kernel-owner+w=401wt.eu-S1753615AbXAAIyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXAAIyL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbXAAIyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:54:11 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41755
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753615AbXAAIyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:54:10 -0500
Date: Mon, 01 Jan 2007 00:54:09 -0800 (PST)
Message-Id: <20070101.005409.38712613.davem@davemloft.net>
To: dmk@flex.com
Cc: hch@infradead.org, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <45988210.7070300@flex.com>
References: <20061231154103.GA7409@infradead.org>
	<20061231.124612.21926488.davem@davemloft.net>
	<45988210.7070300@flex.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Kahn <dmk@flex.com>
Date: Sun, 31 Dec 2006 19:37:52 -0800

> IMHO, the directory entries in the filesystem
> should be in the form "node-name@unit-address" (eg: /pci@1f,0,
> "pci" is the node name, "@" is the separator character defined
> by IEEE 1275, and "1f,0" is the unit-address,
> which are always guaranteed to be unique. That's part of the
> reason we did a separate implementation. I'm not sure
> how we'll resolve that part of it or what problem that
> code is trying to resolve by changing the directory names
> that appear in the filesystem in a rather odd way. It's
> not possible to have two ambiguously fully qualified nodes in the OFW
> device tree, otherwise you would never be able to select
> a specific one by name.

Absolutely, and if you look that's how Sparc's openpromfs names
things now.  It even goes through all of the trouble to make
sure the unit addressing matches what the Sparc OBP uses
precisely.
