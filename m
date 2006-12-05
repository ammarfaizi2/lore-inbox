Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758400AbWLEFcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758400AbWLEFcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758476AbWLEFcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:32:33 -0500
Received: from ozlabs.org ([203.10.76.45]:41720 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758397AbWLEFcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:32:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17781.27.369430.322758@cargo.ozlabs.ibm.com>
Date: Tue, 5 Dec 2006 16:14:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
References: <20061204204024.2401148d.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> ppc-m48t35-add-missing-bracket.patch
> powerpc-replace-kmallocmemset-with-kzalloc.patch

These are already in Linus' tree.

>  Am holding onto these until the powerpc git tree gets un-messied up.

It should be fine now.  Linus has pulled it, so there are currently no
changes in powerpc.git relative to Linus' tree.

> radix-tree-rcu-lockless-readside.patch
> 
>  There's no reason to merge this yet.

We want to use it in some powerpc arch code.  Currently we use a
per-cpu array of spinlocks, and this patch would let us get rid of
that array.

Paul.
