Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUHRVd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUHRVd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267796AbUHRVdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:33:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267826AbUHRVdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:33:42 -0400
Date: Wed, 18 Aug 2004 14:30:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-Id: <20040818143029.23db8740.davem@redhat.com>
In-Reply-To: <20040818210503.GG11200@holomorphy.com>
References: <20040818133348.7e319e0e.pj@sgi.com>
	<20040818205338.GF11200@holomorphy.com>
	<20040818135638.4326ca02.davem@redhat.com>
	<20040818210503.GG11200@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 14:05:03 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> We should pass 64-bit values to remap_page_range() also, then. Or
> perhaps passing pfn's to both suffices, as it all has to be page
> aligned anyway.

Does not work on a system who has more physical address bits
than 32 + PAGE_SHIFT

Sparc32 does not fall into this category... but some other
might.
