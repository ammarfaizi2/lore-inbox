Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWCGX0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWCGX0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWCGX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:26:47 -0500
Received: from hera.kernel.org ([140.211.167.34]:8837 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964801AbWCGX0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:26:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Date: Tue, 7 Mar 2006 15:26:05 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dul4qd$100$1@terminus.zytor.com>
References: <0.399206195@selenic.com> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1141773965 1025 127.0.0.1 (7 Mar 2006 23:26:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 7 Mar 2006 23:26:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060225212247.GC15276@flint.arm.linux.org.uk>
By author:    Russell King <rmk+lkml@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
> 
> All these are to do with decompressing a compressed kernel.  If they
> fail, halting is perfectly reasonable because we probably don't have
> an executable kernel.  Your arguments are fine for these.  But, that's
> not the full story - there are two more places where this code is
> used:
> 
> init/do_mounts_rd.c:#include "../lib/inflate.c"
> init/initramfs.c:#include "../lib/inflate.c"
> 
> for these your arguments that halting is fine is _NOT_ correct nor is it
> desirable.  The first of these is the cause of the problems both myself
> and others saw, as detailed in the URL I posted previously in this thread.
> Did you read that post?
> 

These probably should use lib/zlib instead...

	-hpa
