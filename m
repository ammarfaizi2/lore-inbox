Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUF1WaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUF1WaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUF1WaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:30:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36768 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262085AbUF1WaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:30:10 -0400
Date: Mon, 28 Jun 2004 15:28:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH] dma_get_required_mask()
Message-Id: <20040628152839.23178136.davem@redhat.com>
In-Reply-To: <1088457050.2004.40.camel@mulgrave>
References: <1088457050.2004.40.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2004 16:10:43 -0500
James Bottomley <James.Bottomley@steeleye.com> wrote:

> This patch implements dma_get_required_mask() which may be used by
> drivers to probe the optimal DMA descriptor type they should be
> implementing on the platform.

Maybe you should tweak the default implementation such that
something reasonable happens on 64-bit platforms that
define dma_addr_t as a 32-bit quantity. :-)

Of course, you've provided ARCH_HAS_DMA_GET_REQUIRED_MASK
in order to deal with these cases, so it's not mandatory.
