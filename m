Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWINLwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWINLwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWINLwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:52:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751254AbWINLwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:52:39 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060914112435.4ce28290.sfr@canb.auug.org.au> 
References: <20060914112435.4ce28290.sfr@canb.auug.org.au>  <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com> <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com> 
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of ilog2() on a constant [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 14 Sep 2006 12:52:04 +0100
Message-ID: <21308.1158234724@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After this patch, you don't need to include <linux/compiler.h> any more
> (and, in fact, the file ends up essentially empty).

True.  I could possibly delete the whole file, depending on who else has
designs on it.

> Is there a good reason to move this function out of asm-generic/page.h?

So that all the general log2-based functions are grouped together was what I
was thinking (at least their primary interfaces).

David
