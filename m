Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUFCAvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUFCAvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 20:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265407AbUFCAvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 20:51:23 -0400
Received: from main.gmane.org ([80.91.224.249]:23992 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263864AbUFCAvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 20:51:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.7-rc2-mm1
Date: Wed, 02 Jun 2004 17:51:17 -0700
Message-ID: <pan.2004.06.03.00.51.12.405011@triplehelix.org>
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-223-251.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2004 02:15:39 -0700, Andrew Morton wrote:
> - merged perfctr.  No documentation though :(

In light of all of the problems with perfctr here, I've gone and done the
ifdef work for CONFIG_PERFCTR, presenting an alternative solution to the
struct problem...

http://triplehelix.org/~joshk/perfctr.diff

(note: this includes the earlier fix from wli as well, just for
convenience)

I realize that this might be a problem with regards to maintenance. Doing
this is kind of a pain in the ass.

> -have-xfs-use-kernel-provided-qsort.patch
> -have-xfs-use-kernel-provided-qsort-fix.patch
> 
>  These broke

Broke how? I hadn't seen these patches when I was initially fixing
problems with -rc2-mm1 overall. I even came up with a patch that made XFS
depend on QSORT and remove it from the fs/xfs/Makefile, but I guess that's
exactly what happened here...

Otherwise, XFS has to depend on !QSORT, and that might be bad if anyone
else depends on it. So what's the deal?

-- 
Joshua Kwan


