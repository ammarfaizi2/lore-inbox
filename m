Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUHIL6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUHIL6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUHIL6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:58:30 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:20740 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266495AbUHIL6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:58:25 -0400
Date: Mon, 9 Aug 2004 13:58:22 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Vladislav Bolkhovitin <vst@vlnb.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
In-Reply-To: <20040806155328.GA21546@logos.cnet>
Message-ID: <Pine.LNX.4.58L.0408091350410.7995@blysk.ds.pg.gda.pl>
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net>
 <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net>
 <20040806155328.GA21546@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Marcelo Tosatti wrote:

> Yes correct. *mb() usually imply barrier(). 
> 
> About the flush, each architecture defines its own instruction for doing so,
>  PowerPC has  "sync" and "isync" instructions (to flush the whole cache and instruction 
> cache respectively), MIPS has "sync" and so on..

 JFTR, in the absence of an external write-back buffer (which some
processors have) the MIPS "sync" instruction has exactly the semantics of
mb().  There is no MIPS instruction to perform writeback, invalidation,
etc. operations on whole caches -- such operations can only be performed
in the kernel mode on a line-by-line basis and are model-specific, though
some standardisation exists.

  Maciej
