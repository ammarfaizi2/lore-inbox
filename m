Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265146AbUFBE50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUFBE50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 00:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUFBE5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 00:57:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5034 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265146AbUFBE5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 00:57:24 -0400
Date: Tue, 1 Jun 2004 21:56:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix loop device cache handling
Message-Id: <20040601215610.7ebcc0d9.davem@redhat.com>
In-Reply-To: <20040601180336.C31301@flint.arm.linux.org.uk>
References: <20040601180336.C31301@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 18:03:36 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> The effect of this is that we pull the loop device page into cache
> to exhasibate the problem, since newly allocated pages are _not_
> guaranteed to be completely clean of cache lines in their kernel
> space mapping.
> 
> Note that other drivers need to be audited to ensure that any CPU
> writes to page cache pages have a flush_dcache_page() call.
> 
> This patch adds the necessary missing flush:

I %100 agree with this patch.
