Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVCWSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVCWSFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVCWSFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:05:07 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:10428
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262741AbVCWSE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:04:56 -0500
Date: Wed, 23 Mar 2005 10:02:52 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rth@twiddle.net, akpm@osdl.org, pluto@pld-linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: alpha spinlock.h update
Message-Id: <20050323100252.03d03b9c.davem@davemloft.net>
In-Reply-To: <42419A00.1030206@pobox.com>
References: <20050322130145.69915bea.akpm@osdl.org>
	<20050323144922.GA19677@twiddle.net>
	<42419A00.1030206@pobox.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 11:32:00 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> I wonder if its 4-level page tables.   I think DaveM, in another thread, 
> is chasing flush-<something> issues right now, on sparc64.

It has to do with Hugh Dickin's patches which haven't been
integrated yet.

It may be the case that Alpha needs to override the pgd_addr_end(),
pmd_addr_end(), etc. macros (just like sparc64 and ia64), especially
if there are holes in the Alpha address space.  But my recollection
is that there are not any.

Linus's tree is working just fine for me, it's just the new stuff
Hugh Dickins and Nick Piggin are working on.
