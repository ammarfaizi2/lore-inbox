Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267269AbUHIVQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUHIVQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbUHIVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:14:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10714 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267249AbUHIVNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:13:46 -0400
Date: Mon, 9 Aug 2004 14:11:55 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: bjorn.helgaas@hp.com, akpm@osdl.org, ehm@cris.com, grif@cs.ucr.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-Id: <20040809141155.0c94b8c4.davem@redhat.com>
In-Reply-To: <20040809210335.A9711@infradead.org>
References: <200408091252.58547.bjorn.helgaas@hp.com>
	<20040809210335.A9711@infradead.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 21:03:35 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> Don't use that driver.  qla2xxx is the right driver, and qlogicfc is only
> still there and confuses people because davem is lazy and can shout louder
> than others.

Let me defend myself.

The qla2xxx driver numbers devices differently than qlogicfc does.

The qla2xxx driver never existed upstream until it was added a few
months ago, and even with that it's 2.6.x only, therefore people
using pure upstream kernels for all of their systems (such as myself)
has only the qlogicfc driver to use.

So it's not how loud I can yell or not, it's that not keeping the
qlogicfc driver around would break people's systems.

You could remove the qlogicfc driver if you really wanted, by providing
a config option that would provide qlogicfc compatible device numbering
in the qla2xxx driver.

So implement that instead of bitching about me trying to keep people's
systems functional, ok? :-)
