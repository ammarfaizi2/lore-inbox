Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUFEUVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUFEUVt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUFEUVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:21:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261947AbUFEUVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:21:47 -0400
Date: Sat, 5 Jun 2004 13:19:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Dealing with buggy hardware (was: b44 and 4g4g)
Message-Id: <20040605131923.232f8950.davem@redhat.com>
In-Reply-To: <20040605200643.GA2210@ee.oulu.fi>
References: <20040531202104.GA8301@ee.oulu.fi>
	<20040605200643.GA2210@ee.oulu.fi>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004 23:06:44 +0300
Pekka Pietikainen <pp@ee.oulu.fi> wrote:

> +	if(virt_to_bus(skb->data) + skb->len > B44_PCI_DMA_MAX) {

You can't use this non-portable interface, you have to:

1) pci_map the data
2) test the dma_addr_t returned
