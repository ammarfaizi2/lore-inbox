Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUH1AMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUH1AMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUH1AMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:12:39 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:17794
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267850AbUH1AM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:12:27 -0400
Date: Fri, 27 Aug 2004 17:12:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dave Airlie <airlied@linux.ie>
Cc: hch@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: drm fixup 1/2 - missing bus_address assignment
Message-Id: <20040827171208.51f2811d.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0408280054580.23054@skynet>
References: <Pine.LNX.4.58.0408271510530.32411@skynet>
	<20040827152110.A31641@infradead.org>
	<Pine.LNX.4.58.0408280054580.23054@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 00:55:32 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> > > +			buf->bus_address = virt_to_bus(buf->address);
> >
> > this iw wrong.  never use virt_to_bus in new code and whenever you see it
> > in old code get rid of it.
> >
> 
> Is there an alternative or do I just dump it? I think we only use the
> bus_address for debugging in /proc and I don't think many people actually
> have used it ..

You really have to use the defined DMA apis for stuff like this.

I was going to bark about this too.

Check out Documentation/DMA-mapping.txt and friends.
