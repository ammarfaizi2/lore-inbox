Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUHBXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUHBXQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUHBXQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:16:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263725AbUHBXQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:16:47 -0400
Date: Mon, 2 Aug 2004 16:15:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-Id: <20040802161514.54f02f60.davem@redhat.com>
In-Reply-To: <20040802210119.GS2334@holomorphy.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
	<20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk>
	<20040802130729.2dae8fd5.davem@redhat.com>
	<20040802210119.GS2334@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004 14:01:19 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> I've found unusual results in this area. e.g. it does appear to matter
> for mapping->tree_lock for database workloads that heavily share a
> given file and access it in parallel. The radix tree walk, though
> intuitively short, is long enough to make the rwlock a win in the
> database-oriented uses and microbenchmarks starting around 4x.

Thanks for the data point, because I had this patch I had sent
to Rusty for 2.7.x which ripped rwlocks entirely out of the
kernel.  We might have to toss that idea :-)

