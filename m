Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUBXSmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUBXSmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:42:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262377AbUBXSmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:42:12 -0500
Date: Tue, 24 Feb 2004 10:41:06 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: IOMMUs was Re: Intel vs AMD x86-64
Message-Id: <20040224104106.31f63d10.davem@redhat.com>
In-Reply-To: <20040227022849.6d9f88ef.ak@suse.de>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<20040223134853.5947a414.davem@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<p73r7wk607c.fsf_-_@verdi.suse.de>
	<20040224101340.47341f28.davem@redhat.com>
	<20040227022849.6d9f88ef.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 02:28:49 +0100
Andi Kleen <ak@suse.de> wrote:

> Also the other part of the dumbness is that the flush is global, not per mapping. I guess
> you don't have that problem on Sparc64.

Yes, we can per-page flush, but I don't use that feature at all since I do the "flush all when
wrap around IOMMU pte table" thing we're discussing.  In fact there is no "global flush" so
what I have to do is use diagnostic accesses to the IOMMU TLB to kick out the entries one
by one.
