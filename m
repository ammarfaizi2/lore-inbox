Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUBXSOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbUBXSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:14:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22754 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262381AbUBXSNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:13:45 -0500
Date: Tue, 24 Feb 2004 10:13:40 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: IOMMUs was Re: Intel vs AMD x86-64
Message-Id: <20040224101340.47341f28.davem@redhat.com>
In-Reply-To: <p73r7wk607c.fsf_-_@verdi.suse.de>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<20040223134853.5947a414.davem@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<p73r7wk607c.fsf_-_@verdi.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Feb 2004 15:06:47 +0100
Andi Kleen <ak@suse.de> wrote:

> One side effect of this is that the IOMMU TLB flush strategy is a bit
> dumb, because it has to do config space accesses for it.

This can be costly, but if you flush the IOMMU like sparc64 does (basically
it's similar to how KMAPs are flushed on x86), the cost gets real low because
then you only flush the whole iommu once every time you walk the whole mapping
table of the iommu.

I'm sure you've probably thought of this already, just mentioning it in case
you haven't.
