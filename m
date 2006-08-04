Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWHDK2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWHDK2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWHDK2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:28:36 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:35278 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161140AbWHDK2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:28:35 -0400
Date: Fri, 4 Aug 2006 12:28:22 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD jedec_probe: Recognize Atmel AT49BV6416
Message-ID: <20060804122822.354514e0@cad-250-152.norway.atmel.com>
In-Reply-To: <1154682379.31031.190.camel@shinybook.infradead.org>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	<1154680798.31031.179.camel@shinybook.infradead.org>
	<20060804105220.6d125976@cad-250-152.norway.atmel.com>
	<1154682379.31031.190.camel@shinybook.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2006 17:06:19 +0800
David Woodhouse <dwmw2@infradead.org> wrote:

> On Fri, 2006-08-04 at 10:52 +0200, Haavard Skinnemoen wrote:
> > It is actually a CFI chip. But I couldn't figure out how to install
> > the fixup in the other patch in the CFI code. The AT49BV6416 chip
> > identifies itself as using the AMD command set, so the fixup must be
> > installed based on the jedec ID... 
> 
> Er, note that the _correct_ answer is to advertise the availability of
> the lock functionality in the CFI 'extended query' information. Did
> the hardware designer screw that up?

Hmmm...it looks like the information is there, but the PRI page looks
different than the one defined by the kernel. Which could make sense,
depending on whether "vendor specific" refers to the JEDEC vendor ID of
the device or the command set ID.

I'll try to ask someone from the Atmel flash group about this.

Anyway, I could of course add a fixup based on manufacturer ID and
convert the PRI information into something the kernel understands.
Would that be a better idea?

Haavard
