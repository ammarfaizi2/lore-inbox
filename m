Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263355AbUDVW06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUDVW06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUDVW06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:26:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18828 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263355AbUDVW05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:26:57 -0400
Date: Thu, 22 Apr 2004 15:25:25 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: jmorris@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Large inlines in include/linux/skbuff.h
Message-Id: <20040422152525.28ee1d5f.davem@redhat.com>
In-Reply-To: <20040422222326.GA81305@colin2.muc.de>
References: <m3y8ooawiq.fsf@averell.firstfloor.org>
	<Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
	<20040422222326.GA81305@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2004 00:23:26 +0200
Andi Kleen <ak@muc.de> wrote:

> > Of course, but it would be good to see some measurements.
> 
> It's useless in this case. networking is dominated by cache misses
> and locks and a modern CPU can do hundreds of function calls in a 
> single cache miss.

Indeed, this change does influence the I-cache footprint of the
networking, so I conclude that it is relevant in this case.
