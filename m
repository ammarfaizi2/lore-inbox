Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVBWJyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVBWJyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 04:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVBWJyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 04:54:15 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:3020 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261446AbVBWJwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 04:52:53 -0500
Date: Wed, 23 Feb 2005 10:50:31 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
In-Reply-To: <20050222232002.4d934465.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0502231041450.19035@gockel.physik3.uni-rostock.de>
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org>
 <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com>
 <421C2B99.2040600@ak.jp.nec.com> <20050222232002.4d934465.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005, Andrew Morton wrote:

> We really want to avoid doing such stuff in-kernel if at all possible, of
> course.
> 
> Is it not possible to implement the fork/exec/exit notifications to
> userspace so that a daemon can track the process relationships and perform
> aggregation based upon individual tasks' accounting?  That's what one of
> the accounting systems is proposing doing, I believe.
> 
> (In fact, why do we even need the notifications?  /bin/ps can work this
> stuff out).


I had started a proof of concept implementation that could reconstruct the 
whole process tree from userspace just from the BSD accounting currently 
in the kernel (+ the conceptual bug-fix that I misnamed "[RFC] "biological 
parent" pid"). This could do the whole job ID thing from userspace.
Unfortunately, I haven't had time to work on it recently.

Also, doing per-job accounting might actually be more lightweight than 
per-process accounting, so I'm not at all opposed to unifying CSA and BSD 
accounting into one mechanism that just writes different file formats.

A complete framework seems like overkill to me, too.

Tim
