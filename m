Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265131AbUEYXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265131AbUEYXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUEYXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:12:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265131AbUEYXMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:12:51 -0400
Date: Tue, 25 May 2004 16:12:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Doug Dumitru <doug@easyco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed
 (gfp=0x20/1) - Not out of memory
Message-Id: <20040525161212.6478216e.davem@redhat.com>
In-Reply-To: <40B3C816.6030802@easyco.com>
References: <40B3C816.6030802@easyco.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 15:26:30 -0700
Doug Dumitru <doug@easyco.com> wrote:

> This is the original trap dump from a __page_alloc error
> 
> __alloc_pages: 0-order allocation failed (gfp=0x20/1)

0x20 means GFP_ATOMIC which means it's fine to fail
and e1000 is doing nothing wrong.  GFP_ATOMIC in interrupts
is a fine condition.
