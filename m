Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUKPAI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUKPAI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUKPAH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:07:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:916 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261686AbUKPAHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:07:49 -0500
Date: Tue, 16 Nov 2004 00:07:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] -mm check_rlimit oops on p->signal
In-Reply-To: <20041115154346.33089c0b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0411160000430.2835-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > +	if (likely(p->signal && p->exit_state < EXIT_ZOMBIE)) {
> 
> Worried.  This places an ordering interpretation on TASK_* and EXIT_* which
> AFAIK hadn't been there beforehand.  If someone later comes along and adds

I understand your concern, but kernel/exit.c already contained several
tests for "exit_state >= EXIT_ZOMBIE", so I followed those precedents.

Hugh

