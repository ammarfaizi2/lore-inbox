Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTI2WOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTI2WOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:14:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21125 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261984AbTI2WOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:14:51 -0400
Date: Mon, 29 Sep 2003 23:13:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@colin2.muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030929221346.GA25171@mail.jlokier.co.uk>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk> <20030929174910.GA90905@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929174910.GA90905@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I guess they should be added to the AMD64 version too. It ignores
> all bases, but I'm not sure if the CPU catches the case where the linear
> address computation wraps.

The linear address is _allowed_ to wrap on x86, and there are real
DOS-era programs which take advantage of this.  It is used to create
the illusion of access to high addresses, by making them wrap to low
ones which can be mapped.

Some DOS extenders did this so that 32-bit programs could access BIOS
and video memory in the same DS segment as normal code, despite having
a large segment base address so that null pointers would be trapped by
page protection.

Of course no linux programs do this :)
(Well, maybe some do under DOSEMU?)

So it seems quite likely that the AMD64 CPU simply allows wrapping in
the linear address calculation.

-- Jamie
