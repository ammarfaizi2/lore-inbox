Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWIOOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWIOOnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWIOOnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:43:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751586AbWIOOnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:43:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060915113516.ae2c788c.sfr@canb.auug.org.au> 
References: <20060915113516.ae2c788c.sfr@canb.auug.org.au>  <20060914112435.4ce28290.sfr@canb.auug.org.au> <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com> <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com> <21308.1158234724@warthog.cambridge.redhat.com> 
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of ilog2() on a constant [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 15 Sep 2006 15:42:42 +0100
Message-ID: <13274.1158331362@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Except the get_order() interface is purely related to pages (the fact
> that you have reimplemented it using the log2-based functions is just an
> implementation detail.

Do you have a major objection to it moving to linux/log2.h (do you count the
one you've just raised as "major")?

I'd rather avoid including linux/log2.h or linux/kernel.h in asm/page.h, plus
asm-generic/page.h isn't used by all archs (though that's a minor point).

David
