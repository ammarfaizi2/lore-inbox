Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUF1WmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUF1WmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUF1Wli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:41:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265270AbUF1WlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:41:12 -0400
Date: Mon, 28 Jun 2004 15:39:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH] dma_get_required_mask()
Message-Id: <20040628153941.1317d9bf.davem@redhat.com>
In-Reply-To: <1088462407.2003.54.camel@mulgrave>
References: <1088457050.2004.40.camel@mulgrave>
	<20040628152839.23178136.davem@redhat.com>
	<1088462407.2003.54.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2004 17:40:06 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Mon, 2004-06-28 at 17:28, David S. Miller wrote:
> > Maybe you should tweak the default implementation such that
> > something reasonable happens on 64-bit platforms that
> > define dma_addr_t as a 32-bit quantity. :-)
> 
> Actually, the default implementation should work on these platforms
> too.  Since it's impossible to set a mask over 32 bits, then the best
> dma_get_required_mask() will do is return a full spread of 32 bits,
> since the memory mask is anded with the current dma mask.

Perfect, I didn't notice that.
