Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUHTRDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUHTRDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUHTRDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:03:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268250AbUHTRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:03:48 -0400
Date: Fri, 20 Aug 2004 09:58:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, olof@austin.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Better little-endian bitops
Message-Id: <20040820095839.4dc12d67.davem@redhat.com>
In-Reply-To: <16677.41654.992265.563552@cargo.ozlabs.ibm.com>
References: <16677.41654.992265.563552@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 17:05:26 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Below patch reuses the big-endian bitops for the little endian ones, and
> moves the ext2_{set,clear}_bit_atomic functions to be truly atomic
> instead of lock based.
> 
> This requires that the bitmaps passed to the ext2_* bitop functions
> are 8-byte aligned.  I have been assured that they will be 512-byte or
> 1024-byte aligned, and sparc and ppc32 also impose an alignment
> requirement on the bitmap.

Nice.  I noticed this trick before in the s390 headers.
I'll do this on sparc64 too...
