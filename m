Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWIZJgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWIZJgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIZJgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:36:05 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:36110 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1750783AbWIZJgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:36:03 -0400
Subject: Re: [PATCH 0/3] at91_serial: Introduction
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060926112757.03dd8cbc@cad-250-152.norway.atmel.com>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	 <20060923211417.GB4363@flint.arm.linux.org.uk>
	 <1159261584.24659.16.camel@fuzzie.sanpeople.com>
	 <20060926112757.03dd8cbc@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159262891.24662.25.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Sep 2006 11:28:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> Maybe we can agree on a platform_data format so
> that we can remove the #ifdef altogether?

The platform_data structure is currently defined in
include/asm-arm/arch-at91rm9200/board.h as:

struct at91_uart_data {
	short	use_dma_tx;	/* use transmit DMA? */
	short	use_dma_rx;	/* use receive DMA? */
};

I don't think the DMA-support is currently in mainline, but is in the
pending patches on http://maxim.org.za/AT91RM9200/2.6/

I guess we can just add another field:
	short	no_remap;	/* base address is already mapped */
(or something similar)


Regards,
  Andrew Victor


