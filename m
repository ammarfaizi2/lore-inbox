Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVKFRhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVKFRhw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVKFRhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:37:52 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33231 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932234AbVKFRhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:37:51 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/14] mm: opt rmqueue
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au>
From: Andi Kleen <ak@suse.de>
Date: 06 Nov 2005 18:37:49 +0100
In-Reply-To: <436DBCBC.5000906@yahoo.com.au>
Message-ID: <p73br0x3ceq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> 1/14
> 
> -- 
> SUSE Labs, Novell Inc.
> 
> Slightly optimise some page allocation and freeing functions by
> taking advantage of knowing whether or not interrupts are disabled.

Another thing that could optimize that would be to use local_t
for the per zone statistics and the VM statistics (i have an
old patch for the later, needs polishing up for the current
kernel) 
With an architecture optimized for it (like i386/x86-64) they
generate much better code.

-Andi
