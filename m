Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVCVUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVCVUbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCVU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:29:08 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:49108
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261922AbVCVUXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:23:36 -0500
Date: Tue, 22 Mar 2005 12:21:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322122157.05873870.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
	<20050322112329.70bde057.davem@davemloft.net>
	<Pine.LNX.4.61.0503221931150.9348@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 19:36:46 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> I notice that although both i386 and sparc64 use pgtable-nopud.h, the
> i386 pud_clear does nothing at all and the sparc64 pud_clear resets to 0.

Aha!  And ppc does as well via asm-generic/4level-fixup.h which is
probably why I did it this way as well when I converted sparc64
over to asm-generic/pgtable-nopud.h

Hmmm, let me play around with this.
